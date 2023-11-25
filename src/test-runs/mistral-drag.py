from transformers import AutoTokenizer, AutoModelForCausalLM  

tokenizer = AutoTokenizer.from_pretrained("dragon-mistral-7b-v0")  
model = AutoModelForCausalLM.from_pretrained("dragon-mistral-7b-v0")  

