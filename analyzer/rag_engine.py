from analyzer.embedder import get_embedding
from analyzer.vector_store import query_db
from analyzer.function_parser import extract_functions

def process_contract(file_path: str):
    functions = extract_functions(file_path)

    print(f"[DEBUG] Extracted {len(functions)} functions from Slither")

    all_results = []

    for func in functions:
        embedding = get_embedding(func)
        results = query_db(embedding)

        all_results.append({
            "function": func,
            "results": results
        })

    return all_results