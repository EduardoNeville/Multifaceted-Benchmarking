# Load model directly
from transformers import AutoTokenizer, AutoModelForCausalLM

tokenizer = AutoTokenizer.from_pretrained("models/OpenHermes-2.5-Mistral-7B/tokenizer.model")
model = AutoModelForCausalLM.from_pretrained("models/OpenHermes-2.5-Mistral-7B/")

print(tokenizer)
print(model)

prompt= "Hello how are you"

model_inputs = tokenizer([prompt], return_tensor="pt")

generated_ids = model.generate(**model_inputs, max_new_tokens=100, do_sample= True)
print(tokenizer.batch_decode(generated_ids)[0])


