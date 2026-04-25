from slither.slither import Slither


def extract_functions(file_path: str):
    try:
        slither = Slither(file_path)
    except Exception as e:
        print(f"Error: {e}")
        return []

    functions = []

    for contract in slither.contracts:
        for function in contract.functions:

            if function.is_constructor:
                continue

            try:
                source = function.source_mapping.content
                if source:
                    functions.append(source)
            except Exception as e:
                print(f"Error parsing function {function.name}: {e}")
                continue

    return functions

# if __name__ == "__main__":
#     # Run the extractor on your test file
#     extracted = extract_functions("test2.sol")
    
#     # Print the output clearly
#     print(f"Extracted {len(extracted)} functions:\n")
#     for i, func in enumerate(extracted):
#         print(f"--- Function {i+1} ---")
#         print(func)
#         print("-" * 20 + "\n")