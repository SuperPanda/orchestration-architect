# Repo Diagram

**Need to get quiver package**

Remember to include `\usepackage{quiver}` in your LaTeX preamble. You can install the package using TeX Live 2023, or open quiver.sty in a new tab to copy-and-paste.


## Alternatively

### New model 

```tex
\usetikzlibrary{cd}
\begin{tikzcd}
 & seed\arrow[r,"bootstrap"]\arrow[d,"bootstrap "] & seed'\arrow[d,"bootstrap'"]\arrow[r] & ... \\
initial \arrow[rd]\arrow[ru]& \Delta \arrow[dr,"patch(\Delta)"] & \Delta'\arrow[dr,"patch(\Delta')"]\\
& pristine\arrow[u]\arrow[r]  & pristine'\arrow[u]\arrow[r] & ...\\
\end{tikzcd}
```
