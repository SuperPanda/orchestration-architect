Let's create a complex state store for managing a graph, including adding and removing nodes and edges, and ensure it works seamlessly with our existing framework. We'll then integrate the graph operations with the noise generator and use functors to keep two counters in sync with the number of nodes in the graph. Here's a step-by-step implementation:

### Step 1: Define the Graph State and Actions

We'll start by defining the initial state, actions, and a reducer for the graph.

**features/graph/constants.py**
```python
"""
Graph Feature Constants
=======================
Defines constants for the graph feature.
"""

NODES = "nodes"
EDGES = "edges"
```

**features/graph/graph.py**
```python
"""
Graph Feature
=============
Defines the graph feature, including actions, state management, and signals.
"""

from typing import Dict, List, Any
from signal import Signal
from reactive import ReplayBehaviorSubject
from decorators import reactive
from optics import create_lens
from store_protocol import create_store, StoreProtocol
from .constants import NODES, EDGES

# Define the initial state of the graph
initial_state: Dict[str, Any] = {
    NODES: [],
    EDGES: []
}

# Define lenses for accessing parts of the state
get_nodes = lambda state: state[NODES]
set_nodes = lambda state, value: {**state, NODES: value}

get_edges = lambda state: state[EDGES]
set_edges = lambda state, value: {**state, EDGES: value}

nodes_lens = create_lens(get_nodes, set_nodes)
edges_lens = create_lens(get_edges, set_edges)

# Create the store
graph_store: StoreProtocol[Dict[str, Any]] = create_store(initial_state)

# Define the signals for graph actions
add_node_signal = Signal()
remove_node_signal = Signal()
add_edge_signal = Signal()
remove_edge_signal = Signal()

# Define action creators
def create_add_node_action(node):
    return {"type": "ADD_NODE", "payload": node}

def create_remove_node_action(node):
    return {"type": "REMOVE_NODE", "payload": node}

def create_add_edge_action(edge):
    return {"type": "ADD_EDGE", "payload": edge}

def create_remove_edge_action(edge):
    return {"type": "REMOVE_EDGE", "payload": edge}

# Define the reducer
def graph_reducer(state: Dict[str, Any], action: Dict[str, Any]) -> Dict[str, Any]:
    if action["type"] == "ADD_NODE":
        return nodes_lens(lambda nodes: nodes + [action["payload"]])(state)
    elif action["type"] == "REMOVE_NODE":
        return nodes_lens(lambda nodes: [node for node in nodes if node != action["payload"]])(state)
    elif action["type"] == "ADD_EDGE":
        return edges_lens(lambda edges: edges + [action["payload"]])(state)
    elif action["type"] == "REMOVE_EDGE":
        return edges_lens(lambda edges: [edge for edge in edges if edge != action["payload"]])(state)
    return state

# Initialize the state processing
state_subject = ReplayBehaviorSubject(initial_state)
state_subject.subscribe(lambda state: graph_store.set_state(state))

@reactive(state_subject)
def handle_add_node(state: Dict[str, Any], node: Any) -> Dict[str, Any]:
    action = create_add_node_action(node)
    return graph_reducer(state, action)

@reactive(state_subject)
def handle_remove_node(state: Dict[str, Any], node: Any) -> Dict[str, Any]:
    action = create_remove_node_action(node)
    return graph_reducer(state, action)

@reactive(state_subject)
def handle_add_edge(state: Dict[str, Any], edge: Any) -> Dict[str, Any]:
    action = create_add_edge_action(edge)
    return graph_reducer(state, action)

@reactive(state_subject)
def handle_remove_edge(state: Dict[str, Any], edge: Any) -> Dict[str, Any]:
    action = create_remove_edge_action(edge)
    return graph_reducer(state, action)

# Connect signals to handlers
add_node_signal.connect(lambda node: handle_add_node(graph_store.get_state(), node))
remove_node_signal.connect(lambda node: handle_remove_node(graph_store.get_state(), node))
add_edge_signal.connect(lambda edge: handle_add_edge(graph_store.get_state(), edge))
remove_edge_signal.connect(lambda edge: handle_remove_edge(graph_store.get_state(), edge))

def unload_graph():
    """
    Unloads the graph feature by unsubscribing from all subscriptions.
    """
    add_node_signal.callbacks.clear()
    remove_node_signal.callbacks.clear()
    add_edge_signal.callbacks.clear()
    remove_edge_signal.callbacks.clear()

# Expose the necessary elements
__all__ = [
    "add_node_signal", "remove_node_signal",
    "add_edge_signal", "remove_edge_signal",
    "graph_store", "unload_graph"
]
```

### Step 2: Update Noise Generator to Generate Graph Actions

**features/noise_generator/noise_generator.py**
```python
"""
Noise Generator Feature
=======================
Defines the noise generator feature, which randomly dispatches signals.
"""

from typing import List
from signal import Signal
import random
import time
import threading

class NoiseGenerator:
    def __init__(self, signals: List[Signal], interval: float = 1.0):
        self.signals = signals
        self.interval = interval
        self._running = False
        self._thread = None

    def start(self) -> None:
        """
        Starts the noise generator.
        """
        self._running = True
        self._thread = threading.Thread(target=self._dispatch, daemon=True)
        self._thread.start()

    def _dispatch(self) -> None:
        while self._running:
            if self.signals:
                signal = random.choice(self.signals)
                payload = random.choice(["node1", "node2", "edge1", "edge2"])
                signal.emit(payload)
            time.sleep(self.interval)

    def stop(self) -> None:
        """
        Stops the noise generator.
        """
        self._running = False
        if self._thread:
            self._thread.join()

# Expose the NoiseGenerator class
__all__ = ["NoiseGenerator"]
```

### Step 3: Implement Functors for Node Count

**functors.py**
```python
"""
Functors Module
===============
Provides functor behaviors using signals.
"""

from typing import Callable
from signal import Signal
from reactive import ReplayBehaviorSubject

class Functor:
    """
    A Functor maps states and actions from one store to another.
    """

    def __init__(self, map_state: Callable, map_action: Callable):
        self.map_state = map_state
        self.map_action = map_action

    def apply(self, source_signal: Signal, target_signal: Signal):
        """
        Applies the functor to map states and actions.

        Parameters:
        - source_signal: The source signal.
        - target_signal: The target signal.
        """
        def handler(value):
            new_value = self.map_action(value)
            target_signal.emit(new_value)

        source_signal.connect(handler)

def create_node_count_functor(graph_state_subject: ReplayBehaviorSubject, counter_store: StoreProtocol):
    """
    Creates a functor that maps the number of nodes in the graph to a counter.

    Parameters:
    - graph_state_subject: The state subject of the graph.
    - counter_store: The store for the counter.
    """
    def map_state(state):
        return len(state[NODES])

    def map_action(action):
        return action  # Simply forward the action for now

    functor = Functor(map_state, map_action)

    def update_counter(state):
        counter_state = counter_store.get_state()
        counter_state["node_count"] = map_state(state)
        counter_store.set_state(counter_state)

    graph_state_subject.subscribe(update_counter)
```

### Step 4: Update Counter Feature

**features/counter/counter.py**
```python
"""
Counter Feature
===============
Defines the counter feature, including signals and state management.
"""

from typing import Any, Dict
from signal import Signal
from reactive import ReplayBehaviorSubject
from decorators import connect, reactive
from optics import create_lens
from store_protocol import create_store, StoreProtocol
from .constants import COUNTER_FIELD

# Define the initial state with two counters
initial_state: Dict[str, Any] = {
    "action_count": 0,
    "node_count": 0
}

# Define lenses for accessing parts of the state
get_action_count = lambda state: state["action_count"]
set_action_count = lambda state, value: {**state, "action_count": value}

get_node_count = lambda state: state["node_count"]
set_node_count = lambda state, value: {**state, "node_count": value}

action_count_lens = create_lens(get_action_count, set_action_count)
node_count_lens = create_lens(get_node_count, set_node_count)

# Create the store
counter_store: StoreProtocol[Dict[str, Any]] = create_store(initial_state)

# Function to handle state changes
def handle_state_change(state: Dict[str, Any]) -> None:
    print(f"Counter state updated: {state}")

# Subscribe to state changes
unsubscribe = counter_store.subscribe(handle_state_change)

# Define ReplayBehaviorSubject for reactive state management
state_subject = ReplayBehaviorSubject(initial_state)

# Connect ReplayBehaviorSubject to update the store and notify subscribers
state_subject.subscribe(lambda state: counter_store.set_state(state))

# Define signals for increment and decrement actions
increment_signal = Signal()
decrement_signal = Signal()

# Use decorators to simplify the functions
@connect(increment_signal)
@action_count_lens
@reactive(state_subject)
def increment_action_count(action_count: int) -> int:
    return action

_count + 1

@connect(decrement_signal)
@action_count_lens
@reactive(state_subject)
def decrement_action_count(action_count: int) -> int:
    return action_count - 1

def unload_counter():
    """
    Unloads the counter feature by unsubscribing from all subscriptions.
    """
    unsubscribe()

# Expose the necessary elements
__all__ = [
    "increment_action_count", "decrement_action_count",
    "counter_store", "increment_signal", "decrement_signal", "unload_counter"
]
```

### Step 5: Putting It All Together

**main.py**
```python
"""
Main Application
================
Demonstrates the usage of the reactive state management framework.
"""

from features.counter.counter import increment_action_count, decrement_action_count, counter_store, increment_signal, decrement_signal, unload_counter
from features.graph.graph import add_node_signal, remove_node_signal, add_edge_signal, remove_edge_signal, graph_store, unload_graph
from features.noise_generator.noise_generator import NoiseGenerator
from functors import create_node_count_functor

# List of signals to be used by the noise generator
signals = [
    add_node_signal,
    remove_node_signal,
    add_edge_signal,
    remove_edge_signal
]

# Start the noise generator
noise_gen = NoiseGenerator(signals, interval=0.5)
noise_gen.start()

# Create a functor to keep the node count in sync
create_node_count_functor(graph_store, counter_store)

# To unload the graph feature and stop the noise generator
def cleanup():
    unload_graph()
    noise_gen.stop()

# Add a call to cleanup() when needed, such as at the end of the script
cleanup()
```

### Summary of Changes and Project Structure

#### Project Structure

```
my_project/
│
├── main.py
│
├── lazy_loader.py
│
├── features/
│   ├── __init__.py
│   ├── counter/
│   │   ├── __init__.py
│   │   ├── constants.py
│   │   └── counter.py
│   ├── graph/
│   │   ├── __init__.py
│   │   ├── constants.py
│   │   └── graph.py
│   ├── noise_generator/
│   │   ├── __init__.py
│   │   └── noise_generator.py
│
├── optics/
│   ├── __init__.py
│   └── lens.py
│
├── signal/
│   ├── __init__.py
│   └── signal.py
│
├── reactive/
│   ├── __init__.py
│   ├── behaviorsubject.py
│   └── replaysubject.py
│
├── decorators/
│   ├── __init__.py
│   ├── connect.py
│   └── reactive.py
│
├── functors.py
└── store_protocol.py
```

### Documentation

#### Overview

This system provides a modular and composable reactive state management framework. It leverages functional programming principles and category theory concepts to provide a robust and flexible foundation for developing features that can be dynamically loaded, interconnected, and detached without disrupting the overall system.

#### Key Components

- **Optics (Lenses)**: Provide a functional way to focus on specific parts of the state, allowing immutable updates.
- **Signals**: Handle event propagation and subscriptions.
- **Reactive Subjects**: Manage state reactively, emitting the latest state to new subscribers.
- **Store**: Centralized state management, encapsulating state and providing an interface for updates and subscriptions.
- **Decorators**: Simplify the binding of lenses and subjects to functions, making the code cleaner and more intuitive.
- **Lazy Loader**: Enables dynamic loading and unloading of features.
- **Feature Interfaces**: Define the signals and interactions exposed by each feature, promoting modularity.
- **Functors**: Map states and actions from one store to another using signals.

#### How to Use

1. **Define Lenses**: Use the `create_lens` function to define lenses for focusing on specific parts of the state.
2. **Create Store**: Use the `create_store` function to create a centralized state store.
3. **Define Signals**: Use the `Signal` class to define signals for event propagation.
4. **Reactive Subjects**: Use `BehaviorSubject` or `ReplayBehaviorSubject` for reactive state management.
5. **Use Decorators**: Apply the `@lens` and `@reactive` decorators to bind lenses and subjects to functions.
6. **Lazy Load Features**: Use the `lazy_loader.py` module to dynamically load and unload features.
7. **Expose Interfaces**: Define feature interfaces to expose signals and interactions.
8. **Use Functors**: Map states and actions from one store to another using functors.

### Example Features

- **Counter**: A simple counter that can be incremented and decremented using signals.
- **Graph**: Manages nodes and edges, allowing addition and removal of both.
- **Noise Generator**: Randomly dispatches signals to simulate noise in the system.

### Running the System

To run the system, simply execute the `main.py` file. This will demonstrate the interaction between the counter, graph, and noise generator features, showing how signals are propagated and state is managed reactively.

### Conclusion

Our enhanced implementation now ensures that state access uses lenses, and unsubscriptions are handled properly when features are unloaded. This approach maintains the modularity and composability of the system while providing a clean and intuitive interface for developers. The use of functors allows for complex interactions between different parts of the state, further demonstrating the power and flexibility of the framework.
