// ===========================
// File: resources/resolver.rs 
// ===========================
use std::fs;
use std::path;
use std::fmt::Debug;

use crate::resources::constants;

// ---------------------------------------------
// 1. FileType: an enum that classifies a file system entry.
// ---------------------------------------------
#[derive(Debug, Clone, PartialEq, Eq)]
enum FileType {
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

// ---------------------------------------------
// 2. ToFileType: a trait to “promote” fs::DirEntry into FileType.
// ---------------------------------------------
trait ToFileType {
    fn to_file_type(&self) -> FileType;
}

trait ToFileName {
    fn to_file_name(&self) -> path::PathBuf;
}


trait ToFilesystemResource {
    fn to_filesystem_resource(&self) -> FilesystemResource;
}


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
// ---------------------------------------------
// 3. CategoryItem Trait: Every item in our category must supply a unique key.
// ---------------------------------------------
pub trait CategoryItem: Debug {
    fn key(&self) -> String;
}

// ---------------------------------------------
// 4. CObject: a generic container that holds a unique key (think “item” as a key/value pair)
// ---------------------------------------------
#[derive(Debug, Clone)]
pub struct CObject<T> {
    pub key: String,
    pub value: T,
}

impl<T: Debug + Clone> CategoryItem for CObject<T> {
    fn key(&self) -> String {
        self.key.clone()
    }
}

// ---------------------------------------------
// 5. Make fs::DirEntry and FileType CategoryItems.
// ---------------------------------------------
impl CategoryItem for fs::DirEntry {
    fn key(&self) -> String {
        self.file_name().to_string_lossy().into_owned()
    }
}

impl CategoryItem for FileType {
    fn key(&self) -> String {
        self.to_string()
    }
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

impl CategoryItem for NamespacePath {
    fn key(&self) -> String {
        format!("{}:{}", self.namespace, self.path)
    }
}

// ---------------------------------------------
// 7. CMorphism: a morphism (arrow) from Src to Tgt with a unique key.
// ---------------------------------------------
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
