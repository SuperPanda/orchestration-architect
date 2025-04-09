 Ideas
 =====

Resource specification for NOTES_DIRECTORY

Resources are defined as by the stem name of a file (files follow same structure in naming)

Resources with same stem, including directories are the same resource

Files with the same stem, but different extensions are considered variations of a resource

Directories with no files that share stem with directory names are the primary resource

Directories with files that match are used to hold assets for the files

The following example has a resource 'SOME FILE' is considers the .txt and .html as variations, and assets are held in the
 directory.

    [1] ./SOME FILE -- OA:EXAMPLE-NAMESPACE:SOME_FILE?type=file
    
    [2] ./SOME FILE.html -- OA:EXAMPLE-NAMESPACE:SOME_FILE?variant=html
    
    [3] ./SOME FILE/ -- OA:EXAMPLE-NAMESPACE:SOME_FILE?type=directory
    
    [4] ./SOME FILE/old/foo/xyz.svg -- OA:EXAMPLE-NAMESPACE:SOME_FILE?type=file#old/foo:xyz.svg

If I want to view all of it OA:EXAMPLE-NAMESPACE:SOME_FILE will refer to [1,2,3]

use ?expanded to list the directory contents, but seeing this will be nested namespaces in
implementation, they should be referred to by the closest namespace 

Possible extensions to permit natural transformations
    OA:DOCUMENTS?environment=workspace:local-dev should include 'Development Journal/Notes' which is at OA:NOTES
 Context: Global, System, Local; Environment: Dev, Test, ...


=========================
Design: Resource Resolver
=========================

Namespace

Let N be a Category representing the namespace domain.
Let n be an object in N representing a namespace.
Let p be an object in N representing a path.

Let F be a category representing the filesystem domain.
Let d be an object in F representing a directory 

Let NamespaceObject be (n,p).
Let NamespaceResource be an Image of (N(n,p)->F).
Let DirectoryObject be the image of the filesystem domain from the cone that maps p -> d.

Let Path 

Query --> Resolver ----> Resource

It resolves «namespace»[?«query_params»][#«resource_item»]

Initial Prototype:
  type ResourceQueryString = String;
  
  fn query(iri: String) -> ResourcesQueryResult


  Namespace ----> Resolution «


 Functor: DirectoryObject to ResourceObject
```
___
 DIR|___DirectoryObjectValue_____[to_file_type]__________Vec<FSResourceProperty>__
 OBJ|__...                  \___[to_file_path]_________/
 VEC|__....
 ...|__...
  par_iter:DirEntryVector----------------------------------------------------|
             par_iter(Unit(DirEntry) x Homset(DirEntry,FSResource))----------|
             in other words parallel the morphisms for each FSResourProperty 
 |____________________________________________________________________________|
     | paralel_fold: convert DirectoryObject to ResourceObject (FOLD)
     |       1. parallel_map: DirectoryEntry to FSResource (Cartesian Product - Directory Entry x FSResourceProps)
     |          1.1 Apply DirectoryEntry x Morphisms_To_FSResource_Props(C x HomSet) (PARALLEL)
     |          1.2 Apply tensors product of the 
     |       1.1 convert each DirectoryEntry to FSResource
     |                 
     |          
     |          
     V 
  
             

 so process directory:
  DirEntryVector
      .parallel_iterate   
          DirEntry.fold
            .parallel_map(to_file_name, to_file_type)
               {file_name,file_type} <- |DirEntry| DirEntry

              FsResource <- {currItem.key, currItem.value}
          ns_resource_key <- (file_name.stem)
          nsResourcesAcc[ns_resource_key].items <- 
          resource_hashmap <- {key: file_name_stem

          
  }
```

 TODO: Make it so Vec can be multithreaded
       perhaps using rayon and par_iter for now
 READ_DIR ----
           Vec(Dirs)
let _ = &resources.iter().for_each(print_entry);
