import hashlib
from pathlib import Path

def calculate_md5(file_path):
    """Re-calculates MD5 for a file on disk."""
    hash_md5 = hashlib.md5()
    try:
        with open(file_path, "rb") as f:
            for chunk in iter(lambda: f.read(4096), b""):
                hash_md5.update(chunk)
        return hash_md5.hexdigest()
    except FileNotFoundError:
        return None

def verify_checksums():
    checksum_file = Path('checksums.txt')
    compiled_dir = Path('../src/test/resources/transform/compiled')

    if not checksum_file.exists():
        print(f"Error: {checksum_file} not found. Run the generator script first.")
        return

    print(f"--- Starting Integrity Check ---\n")
    mismatch_count = 0
    lines = 0

    with open(checksum_file, 'r') as f:
        for line in f:

            # Clean the line and split by the colon
            line = line.strip()
            if not line:
                continue
            lines+=1            
            # Separate filename and expected MD5
            filename, expected_md5 = line.split(':')
            file_path = compiled_dir / filename

            # Re-calculate the hash
            actual_md5 = calculate_md5(file_path)

            if actual_md5 is None:
                print(f"[MISSING] {filename}: File does not exist in 'compiled' folder.")
                mismatch_count += 1
            elif actual_md5 != expected_md5:
                print(f"[WARNING] {filename}: Checksum mismatch!")
                print(f"  Expected: {expected_md5}")
                print(f"  Actual:   {actual_md5}")
                mismatch_count += 1
            else:
                pass
                #print(f"[OK] {filename}")

    print(f"\n--- Verification Complete ---")
    if mismatch_count == 0:
        print(f"All {lines} files passed integrity check.")
    else:
        print(f"Total issues found: {mismatch_count}")

if __name__ == "__main__":
    verify_checksums()