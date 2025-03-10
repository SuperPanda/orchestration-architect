
// -------------------------------------
// File: resources/resolver.rs 
// ------------------------------------
use std::fs;
use std::path::Path;
use std::iter::Iterator;
use std::fmt::{Debug,Formatter};

use sophia::api::ns::owl;

use crate::resources::constants;


// For later use when building the new view of resources
enum ResourceKind {
    File,
    Directory,
    Composite
}

pub fn query(namespace: &str){
    let path: &String = match namespace {
        constants::NOTES_NAMESPACE => &constants::NOTES_DIRECTORY,
        _ => {
            eprintln!("Unknown namespace: {}", namespace);
            return;
        }
    };
    println!("resource path: {0}", path);
    list_resources(&path, &namespace);
}

// Resource specification for NOTES_DIRECTORY
// Resources are defined as by the stem name of a file (files follow same structure in naming)
// Resources with same stem, including directories are the same resource
// Files with the same stem, but different extensions are considered variations of a resource
// Directories with no files that share stem with directory names are the primary resource
// Directories with files that match are used to hold assets for the files
// The following example has a resource 'SOME FILE' is considers the .txt and .html as variations, and assets are held in the
// directory.
//    [1] ./SOME FILE -- OA:EXAMPLE-NAMESPACE:SOME_FILE?type=file
//    [2] ./SOME FILE.html -- OA:EXAMPLE-NAMESPACE:SOME_FILE?variant=html
//    [3] ./SOME FILE/ -- OA:EXAMPLE-NAMESPACE:SOME_FILE?type=directory
//    [4] ./SOME FILE/old/foo/xyz.svg -- OA:EXAMPLE-NAMESPACE:SOME_FILE?type=file#old/foo:xyz.svg
// If I want to view all of it OA:EXAMPLE-NAMESPACE:SOME_FILE will refer to [1,2,3]
//    use ?expanded to list the directory contents, but seeing this will be nested namespaces in
//    implementation, they should be referred to by the closest namespace 
// Possible extensions to permit natural transformations
//    OA:DOCUMENTS?environment=workspace:local-dev should include 'Development Journal/Notes' which is at OA:NOTES
// Context: Global, System, Local; Environment: Dev, Test, ...
//
//   
pub fn list_resources(path: &str, namespace: &str){
    let resources: Vec<fs::DirEntry> = fs::read_dir(path)
        .into_iter()
        .flatten()
        .filter_map(Result::ok).collect();
        //println!("{:?}",resources);

    //let _ = &resources.iter().for_each(print_entry);
    let names: Vec<String> = resources.iter().map(|entry: &fs::DirEntry| { extract_name(&entry) }).flatten().collect();
    let types: Vec<EntryType> = resources.iter().map(|entry: &fs::DirEntry| { extract_type(&entry) }).flatten().collect();
    print_entries(&resources);
    print_entries(&names);
    print_entries(&types);
    //let _ = &names.iter().for_each(print_entry);

}


// function to turn DirEntry into <name, Direntry>
// function to reduce <name,DirEntry> so that for each name, DirEntry + is_file and hashmap from
// name to resource, if exists already make composite, if dir use dir, if file use file

//
//
enum EntryType {
    File,
    Directory,
    Other
}


trait Mappable<T> {    
    fn to(self:Self) -> T;
}

impl std::fmt::Debug for EntryType {
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
        let value = &self.to();
        write!(f,"{0}", value)
    }

}
impl Mappable<String> for &EntryType {
    fn to(self) -> String {
        let output = match self {
            EntryType::Directory => "directory",
            EntryType::File => "file",
            EntryType::Other => "unknown"
        };
        let output = output.to_string();
        output

    }
}

impl Mappable<EntryType> for std::fs::FileType {
    fn to(self) -> EntryType {
        if self.is_file() { return EntryType::File; };
        if self.is_dir() { return EntryType::Directory; };
        return EntryType::Other;
    }
}

fn print_entries(entries: &Vec<impl std::fmt::Debug>){
    entries.iter().for_each(print_entry);
}

fn print_entry(item: impl std::fmt::Debug) -> (){
    println!("{:?}",&item);
}

fn extract_type(entry: &fs::DirEntry) -> Option<EntryType> {
    //print_entry(entry.file_type());
    let file_type: Result<std::fs::FileType,_> = entry.file_type();
    file_type.ok().and_then(|output| Some(output.to()))
    
}

fn extract_name(entry: &fs::DirEntry) -> Option<String> {
    entry.file_name()
        .to_str()
        // Get name from file stem
        .and_then(|path| Path::new(path).file_stem())
        // Convert to string
        .map(|stem| { format!("{0}",stem.to_string_lossy())})
}
