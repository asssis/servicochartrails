if(true)
  Product.find_or_create_by(descricao: 'arroz', valor: 3.50, codigo: 1)
  Product.find_or_create_by(descricao: 'feijão', valor: 4.50, codigo: 2)
  Product.find_or_create_by(descricao: 'macarrão', valor: 2.50, codigo: 3)
  Product.find_or_create_by(descricao: 'leite', valor: 3.70, codigo: 4)
  Product.find_or_create_by(descricao: 'sabão', valor: 8.50, codigo: 5)
  Product.find_or_create_by(descricao: 'oleo', valor: 4.50, codigo: 6)
  Product.find_or_create_by(descricao: 'sabão', valor: 8.50, codigo: 7)
  Product.find_or_create_by(descricao: 'sabonete', valor: 1.50, codigo: 8)
  Product.find_or_create_by(descricao: 'creme dental', valor: 4.50, codigo: 9)
  Product.find_or_create_by(descricao: 'sal', valor: 6.50, codigo: 10)
  Product.find_or_create_by(descricao: 'açucar', valor: 6.50, codigo: 11)
end

puts '-inicio-'
data = DateTime.now - 2.year
p = Product.all
while data < DateTime.now
  index = rand(1...p.length)
  quantidade = rand(1..5)
  Sale.create(product_id: p[index].id,date: data, quantidade: quantidade , total: quantidade * p[index].valor.to_f)
  data += 1
end
puts '-fim-'
