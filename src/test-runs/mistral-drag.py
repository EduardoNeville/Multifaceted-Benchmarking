# Load model directly
import torch
from transformers import AutoTokenizer, AutoModelForCausalLM

device = torch.device("cuda" if torch.cuda.is_available() else "cpu")

dir_cache = f"models/{input()}"

tokenizer = AutoTokenizer.from_pretrained("OpenHermes-2.5-Mistral-7B", cache_dir= dir_cache)
model = AutoModelForCausalLM.from_pretrained("OpenHermes-2.5-Mistral-7B", cache_dir= dir_cache)

print(tokenizer)
print(model)

prompt= "Hello how are you"

model_inputs = tokenizer(prompt, return_tensor="pt")

generated_ids = model.generate(**model_inputs, max_new_tokens=100)
print(tokenizer.batch_decode(generated_ids)[0])


