I am trying to distill the idea module structure, and identify how to simplify the code base so it allows for module catlib to be correct and clean, this is a prototype idea, where i have added all the ideas to link different resources so i have a way to perform operations on different namespaces, so i can have a bifunctor between different systems using applied category theory. so i need to make sure that the catlib allows for the construction of arrows between structures, to be able to allow for easy use of the lib, and i need to make sure all the types for the file system stuff, is in the protocol::fs module, i will need to consider how i want to structure the packages, since all this is in the resource/resolver.rs file and by another module, we will consider that will later be split into resources::protocols::{oa,core,fs}, where core will in core, and ::oa and ::fs will be where i put the impl and stuff, so like the protocol oa would be the oa domain where i refer to the oa project this is meant to map resources into/from, and fs will be resources into/from and core will be the part where i will implement the category stuff, as it is meant to allow me to naturally transform based on domain, and keep things in sync, like if i map oa specs to oa implementation, i can see whats missing, and vice verse, and create a semantic web.

The important part is refactoring it, with the goal of making the api for the protocol very clear (In Particular i mean the catlib) as it is giving me issues, and will be the basis of the refactoring. lifetime issues, and not having proper tests, and not having a clear mental model of how the parts fit together, like what is unnecessary, what is. Note I ideally want to use CObject and CMorphism to be the building blocks such that they can be used to apply compatibility with the lifetimes and etc. i need to ensure that it is clearly documented, as i will need to go through and make sure that everything is correct. with the idea that literate writing can be used to describe the concept as documentation, an implementation, the tests and the usage and have a good overall architecture for using the building blocks in a natural way, such that it takes advantage of the type system. the catlib is designed to be able to create structure-preserving operations and achieve coherence and naturality between semantics, different system domains, and as a tool to think and reason, i,e, how do i map a operation to ensure that i can design the system to naturally cascade changes to structure. i want you to recommend improvements and changes (don't worry about breaking compatibility with the existing implementation, i am brainstorming the ideal representation, with the idea that the structures are suitable for both parallel and sync based on the isomorphism between the monoidial preorder category resource thing from applied category theory. i also want a clean and demonstrative design of the elegance that comes from using category theory. rewrite this, and include all the information i gave you and in the comments, to help me design the project. and make recommendations in the format of a literate documentation (knuth style). write description of the architecture in docstrings as well

Result from running `tree` on the 'orchestration-architect-prototype/oa-cli/src' directory

```tree

/home/panda/repos/orchestration-architect-prototypes/oa-cli/src/
├── commands
│   ├── mod.rs
│   ├── notes.rs
│   └── tasks.rs
├── core
│   └── mod.rs
├── lib.rs
├── main.rs
└── resources
    ├── constants.rs
    ├── mod.rs
    ├── resolver.rs
    ├── resolver.rs.old
    ├── resolver.rs.old.1
    └── resolver.rs.old.2

4 directories, 12 files
```

```rust
// ===========================
// File: resources/resolver.rs 
// ===========================
use std::fs;
use std::path;
use std::fmt::Debug;

// move target into crate::resources::namespaces and use macro for code gen
use crate::resources::constants;
// Prototype
pub mod protocol {
    //pub enum Protocol {
    //    FS, // filesystem resource protocol
        // git, // git resource protocol
    //    OA, // orchestration architect resource protocol
    //}    
    pub mod core {
        // Todo: Turn into Requirements that will be an example. 'oa:requirements:prototype#'
        // Also need to be able to configure mappings.
        // Need to allow mapping between protocols. 
        // Example:
        //      use crate::resolver::{Protocol::{oa,fs}}
        //          to provide impl for crate::resolver::core 
        //      - let msg:<impl Protocol:fs> = resolver.message(oa::Command::List, "oa:notes?....#<to be specified>")
        //        shhould list all the paths like Resource{ path, name, items: <impl fs.Resource> }
        //      - based on the type of the 
        //        noting that path is relative to the namespace of NOTES (all stem names is 
        //        same resource under certain resources
        //      - send message to protocol translator 
        //
        //      - let Message:<impl resolver::protocol::fs> = 
        //      - send and receieve
        //      
        //      struct Message(Protocol,Command,Resource,Query,Fragment)
        //      - Parse `OA LIST oa:notes?type=Idea#`
        //        so that
        //        Message(protocol::Protocol::oa, protocol::Protocol
        //      Message(OA
        //      Message(
        //      OR  oa:tasks?status=wip
        //
        //         fs://<PATH TO OA NOTES>/
        //          
        // and      oa:notes#OA-NOTE-000
        //
        struct Protocol;
        struct Resource;
        struct Command;
        struct Query;
        struct Fragment;
        pub enum ResourceCommand {
            List            
        }
        //struct Command(ResourceCommand);        
    }

    pub mod fs {
        #[derive(Debug, Clone, PartialEq, Eq)]
        pub enum FileType {
            Directory,
            File,
            Symlink,
            Other,
        }

        impl ToString for FileType {
            fn to_string(&self) -> String {
                match self {
                    FileType::Directory => "Directory".to_string(),
                    FileType::File      => "File".to_string(),
                    FileType::Symlink   => "Symlink".to_string(),
                    FileType::Other     => "Other".to_string(),
                }
            }        
        }

        impl Into<String> for FileType {
            fn into(self) -> String {
                self.to_string()
            }        
        }
    }
       #[cfg(test)]
        mod tests {
            #[test]
            fn test_file_type_into_string(){
                let result: String = super::fs::FileType::File.into();
                assert_eq!(result,"File".to_string());
            }
        }

    pub mod catlib {
        use std::fmt::Debug;
        use std::ops::Add;

        /// CObject: A container that wraps any value with a key (for identification, debugging, etc.)
        #[derive(Debug, Clone)]
        pub struct CObject<T> {
            pub key: String,
            pub value: T,
        }

        impl<T> CObject<T> {
            /// Construct a new CObject from a key and a value.
            pub fn new(key: impl Into<String>, value: T) -> Self {
                Self { key: key.into(), value }
            }
        }

        /// CMorphism: Represents a transformation (arrow) from type `Src` to type `Tgt`.
        /// The arrow carries a key and a boxed function.
        pub struct CMorphism<'a, Src, Tgt> {
            pub key: String,
            pub value: Box<dyn Fn(Src) -> Tgt + 'a>,
        }

        impl<'a, Src, Tgt> CMorphism<'a, Src, Tgt> {
            /// Construct a new CMorphism from a key and a function.
            pub fn new(key: impl Into<String>, f: impl Fn(Src) -> Tgt + 'a) -> Self{
                CMorphism { key: key.into(), value: Box::new(f) }
            }

            /// Apply the morphism to an input value.
            pub fn apply(&self, src: Src) -> Tgt {
                (self.value)(src)
            }

            /// Compose two morphisms: For `f: A → B` and `g: B → C` the composition
            /// yields `g ∘ f : A → C`.
            pub fn compose<NextTgt>(self, next: CMorphism<'a, Tgt, NextTgt>) -> CMorphism<'a, Tgt, NextTgt>{
                type NextTgt = CMorphism<'a, NextTgt>;
                let composed_key = format!("{} ∘ {}", next.key, self.key);
                CMorphism::new(composed_key, move |x: Src| {
                    let mid = (self.value)(x);
                    (next.value)(mid)
                })
            }

            /// map_output: Transform the output of this morphism.
            pub fn map_output<U>(self, f: impl Fn(Tgt) -> U + 'a) -> CMorphism<'a, Src, U> {
                self.compose(CMorphism::new("fmap", f))
            }
        }

        /// Overload the `+` operator to allow intuitive composition: `f + g` means g ∘ f.
        impl<'a, Src, Mid, Tgt> Add<CMorphism<'a, Mid, Tgt>> for CMorphism<'a, Src, Mid> {
            type Output = CMorphism<'a, Src, Tgt>;
            fn add(self, rhs: CMorphism<'a, Mid, Tgt>) -> Self::Output {
                self.compose(rhs)
            }
        }

        /// An identity morphism for any type.
        pub fn identity<T: 'static + Debug>() -> 'static + CMorphism<T, T>{
            CMorphism::new("id", |x| x)
        }

        #[cfg(test)]
        mod tests {
            use super::*;
            #[test]
            fn test_cmorphism_operations() {
                let add_one = CMorphism::new("add_one", |x: i32| x + 1);
                let double = CMorphism::new("double", |x: i32| x * 2);
                let composed = add_one.compose(double);
                assert_eq!(composed.apply(2), 2 * (2 + 1)); // 2 * 3 = 6

                // Alternatively, testing the `+` operator overload.
                let composed2 = CMorphism::new("add_one", |x: i32| x + 1)
                    + CMorphism::new("double", |x: i32| x * 2);
                assert_eq!(composed2.apply(3), (3 + 1) * 2); // 4 * 2 = 8
            }
        }
    }
}

use crate::resources::resolver::protocol::fs::FileType;
//

// ---------------------------------------------
// 1. Start with COMMAND,Resource(Protocol,Namespace,Path),Query,Fragmen // Request -> Response
//    pattern // be able to listen on multiple ends // Warp Websocket server + Svelte
// ---------------------------------------------

// ---------------------------------------------
// 2. ToFileType: a trait to “promote” fs::DirEntry into FileType.
// ---------------------------------------------
// TODO: Make it so .into just works for DirEntry, etc.
trait ToFileType {
    fn to_file_type(&self) -> FileType;
}

trait ToFileName {
    fn to_file_name(&self) -> path::PathBuf;
}


trait ToFilesystemResource {
    fn to_filesystem_resource(&self) -> FilesystemResource;
}

// Test if I can just make let resource:<impl Resource> = DirEntry.into()
// maybe use a hashmap from keys to categories to (hashset of objects, hashset of morphisms)
// then a closure would be created so f: FnOnce ... that allows for an operation to occur the
// initial object...
impl ToFilesystemResource for fs::DirEntry{
    fn to_filesystem_resource(&self) -> FilesystemResource {
        FilesystemResource {
         name: self.to_file_name().to_string_lossy().to_string(),
         resource_type: self.to_file_type()
        }
    }
}

    impl ToFileType for fs::DirEntry {
        fn to_file_type(&self) -> FileType {
            // If file_type() fails, panic in this toy example.
            let ft = self.file_type().ok().expect("Unable to read file type from Directory Entry");
            if ft.is_symlink() {
                FileType::Symlink
            } else if ft.is_dir() {
                FileType::Directory
            } else if ft.is_file() {
                FileType::File
            } else {
                FileType::Other
            }
        }
    }

impl ToFileName for fs::DirEntry {
    fn to_file_name(&self) -> path::PathBuf {
        let file_path = self.path();
        file_path
    }
}

#[derive(Debug, Clone)]
pub struct CObject<T> {
    pub key: String,
    pub value: T,
}

// ---------------------------------------------
// 6. Domain: NamespacePath represents a namespace and its associated (relative) path.
// ---------------------------------------------
#[derive(Debug, Clone)]
pub struct NamespacePath {
    pub namespace: String,
    pub path: String, // could be a relative path
}

impl NamespacePath {
    pub fn new(namespace: &str, path: &str) -> Self {
        Self {
            namespace: namespace.to_string(),
            path: path.to_string(),
        }
    }
}

//  impl CategoryItem for NamespacePath {
//      fn key(&self) -> String {
//          format!("{}:{}", self.namespace, self.path)
//      }
//  }

// ---------------------------------------------
// 7. CMorphism: a morphism (arrow) from Src to Tgt with a unique key.
// ---------------------------------------------
// TODO: Make it so it works by making all CMorphisms start and end types coerces into 
// CObjects
// make it somehow use the derive macro or something
// want to move away from static lifetimes as i want the lifetimes to be part of the commutativity of the operations.
pub struct CMorphism<Src: 'static, Tgt: 'static> {
    pub key: String,
    pub value: Box<dyn Fn(Src) -> Tgt>,
}

impl<Src, Tgt> Debug for CMorphism<Src, Tgt> {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(f, "CMorphism {{ key: {} }}", self.key)
    }
}

impl<Src, Tgt> CMorphism<Src, Tgt> {
    pub fn apply(&self, src: Src) -> Tgt {
        (self.value)(src)
    }
    
    pub fn compose<NextTgt>(self, next: CMorphism<Tgt, NextTgt>) -> CMorphism<Src, NextTgt> {
        let composed_key = format!("{} ∘ {}", next.key, self.key);
        CMorphism {
            key: composed_key,
            value: Box::new(move |src: Src| {
                let intermediate: Tgt = (self.value)(src);
                (next.value)(intermediate)
            }),
        }
    }
}

// Identity morphism.
pub fn identity<T: 'static + Debug>() -> CMorphism<T, T> {
    CMorphism {
        key: "id".to_string(),
        value: Box::new(|x| x),
    }
}

// ---------------------------------------------
// 8. Domain-specific types for resources (for future expansion)
// ---------------------------------------------
// TODO
struct Resource {}

// impl<T> Resource in protocols
// so in protocols::oa we implement Resource<implements NamespaceResource>
// so in protocols::fs we implement Resource<implements FilesystemResource>
// and the bridge should map back and forth, like namespace<->fs resource, where fs is the image
// under the oa namespace.
#[derive(Debug, Clone)]
pub struct NamespaceResource {
    pub name: String,      // Stem of resource name
    pub path: path::PathBuf,     // Relative path to the namespace
    pub items: Vec<FilesystemResource>,
}

#[derive(Debug, Clone)]
pub struct FilesystemResource {
    pub name: String,      // File or directory name
    pub resource_type: FileType, // File, Directory, etc.
}

// ---------------------------------------------
// 9. query: The entry point. Lookup a namespace string to retrieve a known path
// ---------------------------------------------
pub fn query(namespace: &str) {
    let path: &String = match namespace {
        constants::NOTES_NAMESPACE => &constants::NOTES_DIRECTORY,
        _ => {
            eprintln!("Unknown namespace: {}", namespace);
            return;
        }
    };
    println!("resource path: {}", path);
    list_resources(path, namespace);
}

// ---------------------------------------------
// 10. list_resources:
// Compose the category–theoretic chain to transform a NamespacePath into a directory
// listing and then into file metadata via morphisms. This is where natural transformation
// ideas come to life.
// ---------------------------------------------
pub fn list_resources(path: &str, namespace: &str) {
    // For clarity we alias our types:
    type DirectoryObject = CObject<Vec<fs::DirEntry>>;
    type NamespaceObject = CObject<NamespacePath>;

    // (a) Create the initial object: a NamespacePath wrapped in a CObject.
    let namespace_object: NamespaceObject = CObject {
        key: "namespace_path".to_string(),
        value: NamespacePath::new(namespace, path),
    };
    println!("Initial Namespace Object: key = {}, value = {:?}", 
             namespace_object.key, namespace_object.value);

    // (b) Morphism: Transform a NamespaceObject into a DirectoryObject by reading the directory.
    let read_directory: CMorphism<NamespaceObject, DirectoryObject> = CMorphism {
        key: "read_directory".to_string(),
        value: Box::new(|source_obj: NamespaceObject| {
            // Convert the stored path (a string) to a PathBuf.
            let dir_path = path::PathBuf::from(&source_obj.value.path);
            // Read the directory; if there’s an error, yield an empty vector.
            let entries = fs::read_dir(&dir_path)
                .map(|iter| iter.filter_map(|res| res.ok()).collect::<Vec<fs::DirEntry>>())
                .unwrap_or_else(|err| {
                    eprintln!("Error reading directory {}: {}", dir_path.display(), err);
                    Vec::new()
                });
            CObject {
                key: source_obj.key.clone(),
                value: entries,
            }
        }),
    };

    // (c) Apply the morphism to get the DirectoryObject.
    let directory_object: DirectoryObject = read_directory.apply(namespace_object);
    //directory_object.value.into_iter().for_each(|v| println!("{:?}",v));
    

    type ToFileTypeMorphism = CMorphism<fs::DirEntry, FileType>;
    let to_filesystem_resource: CMorphism<DirectoryObject,Vec<FilesystemResource>> = CMorphism {
        key: "to_filesystem_resource".to_string(),
        value: Box::new(|src_obj: DirectoryObject| 
            src_obj.value.into_iter().map(|entry: fs::DirEntry| entry.to_filesystem_resource()).collect())
    };

    let print_all: CMorphism<Vec<FilesystemResource>,()> = CMorphism {
        key: "print_all".to_string(),
        value: Box::new(|src_obj: Vec<FilesystemResource>| -> () { src_obj.into_iter().for_each(|v: FilesystemResource| -> () { println!("[{0}] {1}", v.resource_type.to_string(), v.name)}) })
    };
    let filesystem_resources = to_filesystem_resource.apply(directory_object);
    print_all.apply(filesystem_resources);

  // Compose additional morphisms to create NamespaceResource or FilesystemResource
}

---

```

