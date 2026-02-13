import subprocess
from pathlib import Path
from concurrent.futures import ProcessPoolExecutor

def compile_single_file(file_path):
    """Worker function to compile one file."""
    target_dir = Path('compiled')
    target_name = f"c_{file_path.stem}.prg"
    target_path = target_dir / target_name

    command = [
        "mospeed.cmd",
        "-generatesrc=true",
        f"-target={target_path}",
        str(file_path)
    ]

    try:
        print(f"Starting: {file_path.name}")
        subprocess.run(command, check=True, capture_output=True, text=True)
        return f"Succeeded: {file_path.name}"
    except subprocess.CalledProcessError as e:
        return f"Failed: {file_path.name} - Error: {e.stderr}"

def main():
    source_dir = Path('.')
    target_dir = Path('compiled')
    target_dir.mkdir(exist_ok=True)

    bas_files = list(source_dir.glob('*.bas'))
    
    # Set the number of parallel threads/processes
    # You can set this to a fixed number (e.g., 4) or None to use all cores
    num_workers = 16 

    print(f"Starting parallel build with {num_workers} workers...\n")

    with ProcessPoolExecutor(max_workers=num_workers) as executor:
        # Map the worker function to the list of files
        results = list(executor.map(compile_single_file, bas_files))

    # Print a summary of the results
    for result in results:
        print(result)

if __name__ == "__main__":
    main()