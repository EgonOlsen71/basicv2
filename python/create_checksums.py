import hashlib
from pathlib import Path

def generate_md5(file_path):
    """Reads a file in chunks and returns the MD5 hex string."""
    hash_md5 = hashlib.md5()
    
    with open(file_path, "rb") as f:
        # Read in 4KB chunks to be memory efficient
        for chunk in iter(lambda: f.read(4096), b""):
            hash_md5.update(chunk)
            
    return hash_md5.hexdigest()

def create_checksum_file():
    compiled_dir = Path('../src/test/resources/transform/compiled')
    output_file = Path('checksums.txt')

    # Get all .prg files
    prg_files = sorted(compiled_dir.glob('*.prg'))

    if not prg_files:
        print("No .prg files found in the compiled directory.")
        return

    print(f"Generating checksums for {len(prg_files)} files...")

    # Using 'with' to ensure the output file is closed properly
    with open(output_file, 'w') as out:
        for file_path in prg_files:
            md5_hash = generate_md5(file_path)
            # Write in the format: <filename>:<md5>
            line = f"{file_path.name}:{md5_hash}\n"
            out.write(line)
            print(f"Processed: {file_path.name}")

    print(f"\nDone! Checksums saved to {output_file}")

if __name__ == "__main__":
    create_checksum_file()