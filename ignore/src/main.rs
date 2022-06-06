use gitignore;
use std::path::Path;
use walkdir::WalkDir;

fn main() {
    let ignore_path = Path::new("/home/john/code/SmallThings/ignore/.gitignore");
    let ignore = gitignore::File::new(ignore_path).unwrap();

    for entry in WalkDir::new("/home/john/code/intern/")
        .into_iter()
        .filter_map(Result::ok)
        .filter(|e| !e.file_type().is_dir())
        .filter(|e| !ignore.is_excluded(e.path()).unwrap()) {
            println!("{:?}", entry.path());
        }
}

