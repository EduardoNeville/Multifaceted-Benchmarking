# Load model directly
import torch
from transformers import AutoTokenizer, AutoModelForCausalLM

device = torch.device("cuda" if torch.cuda.is_available() else "cpu")

print(device)

tokenizer = AutoTokenizer.from_pretrained("teknium/OpenHermes-2.5-Mistral-7B")
model = AutoModelForCausalLM.from_pretrained("teknium/OpenHermes-2.5-Mistral-7B")

prompt= "Hello how are you?"

model_inputs = tokenizer(prompt, return_tensor="pt")

generated_ids = model.generate(**model_inputs, max_new_tokens=100)
print(tokenizer.batch_decode(generated_ids)[0])


