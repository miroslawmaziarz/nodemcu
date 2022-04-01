
store = require('store')

store.write("test", "q,w,es;")
store.write("test", "q,w,e3s;")
store.write("test", "q,w,e3;")
store.write("test", "q,w,e4s;")

print(store.read_all("test"))
print('-----------')
print(store.read_and_clear("test"))
print('-----------')
print(store.read_all("test"))

