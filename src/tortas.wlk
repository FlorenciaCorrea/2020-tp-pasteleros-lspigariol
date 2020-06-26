import pasteleros.*

class Torta {
	
	const property ingredientes = []
	var property coccion 
	var property autor
		
	method agregarIngrediente(producto, peso){
		ingredientes.add(new Ingrediente(producto=producto,peso=peso))
	}
	method pesoTotal() = ingredientes.sum{ing=>ing.peso()}

}


//El jurado presenta un plato terminado modelo, que es una torta de chocolate wollok. 
//Lleva 500 gr de chocolate, 600  gr de harina, 300 gr de azúcar y 100 gr de manteca. También se indica el tiempo de cocción (50 minutos) y quién es el repostero famoso que la creó. 

const tortaWollok = new Torta(
	ingredientes = [
		new Ingrediente(producto="chocolate",peso = 0.5),
		new Ingrediente(producto="harina",peso = 0.6),
		new Ingrediente(producto="azucar",peso = 0.3),
		new Ingrediente(producto="manteca",peso = 0.1)		
	],
	coccion = 50,
	autor = "nadie"
) 

