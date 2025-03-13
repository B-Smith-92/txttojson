import json
import os
import glob
import shutil

def txt_to_json(txt_file_path, json_file_path):
    data = {}
    
    # Read the text file
    with open(txt_file_path, 'r') as file:
        for line in file:
            # Skip empty lines
            if line.strip() == "":
                continue
                
            # Strip whitespace and split by the delimiter
            try:
                key, value = line.strip().split(':', 1)
                data[key.strip()] = value.strip()
            except ValueError:
                print(f"Warning: Line '{line.strip()}' does not contain a colon delimiter. Skipping.")
    
    # Convert dictionary to JSON and write to a file
    with open(json_file_path, 'w') as json_file:
        json.dump(data, json_file, indent=4)
    
    print(f"Converted {os.path.basename(txt_file_path)} to {os.path.basename(json_file_path)}")

def process_all_txt_files():
    # Create output and completed directories if they don't exist
    if not os.path.exists("output"):
        os.makedirs("output")
        print("Created 'output' directory.")
        
    if not os.path.exists("completed"):
        os.makedirs("completed")
        print("Created 'completed' directory.")
        
    # Get all .txt files in the input directory
    txt_files = glob.glob(os.path.join("input", "*.txt"))
    
    if not txt_files:
        print("No .txt files found in the 'input' directory.")
        return
    
    # Process each .txt file
    for txt_file in txt_files:
        # Generate output filename (same name but .json extension)
        base_name = os.path.basename(txt_file)
        json_file = os.path.join("output", os.path.splitext(base_name)[0] + ".json")
        
        # Convert the file
        txt_to_json(txt_file, json_file)
        
        # Move the processed file to the completed folder
        completed_file = os.path.join("completed", base_name)
        shutil.move(txt_file, completed_file)
        print(f"Moved {base_name} to the 'completed' folder.")
    
    print(f"\nProcessed {len(txt_files)} file(s). JSON files saved in the 'output' directory.")

# Run the script
if __name__ == "__main__":
    print("TXT to JSON Converter")
    print("---------------------")
    print("Looking for .txt files in the 'input' directory...\n")
    process_all_txt_files() 