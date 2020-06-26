import tortas.*
import jurado.*

//Marcos
//Su nivel de habilidad depende de sus años de experiencia 
//más la cantidad total de kilogramos de sus ingredientes. 
// Inicialmente cuenta con 1200 gr de chocolate, 300 gr de azúcar y  400 gr de harina, 
//pero a lo largo de la competencia puede ir variando sus ingredientes y las cantidades. 

class Ingrediente {
	var property producto
	var property peso = 0
	
	method aumentarPeso(incremento){
		peso += incremento
	}
}

object marcos {
	var experiencia = 8
	var ingredientes = 
		[new Ingrediente(producto = "chocolate", peso = 1.2),
		new Ingrediente(producto = "azucar", peso = 0.3),
		new Ingrediente(producto = "harina", peso = 0.4)
		]
	method habilidad() {
		return experiencia + self.pesoIngredientes()
	}
	method pesoIngredientes() {
		return ingredientes.sum({ing=>ing.peso()}) 
	}
	method agregarIngrediente(producto,peso) {
		ingredientes.add(new Ingrediente(producto=producto, peso= peso))
	}
//Puede realizarlo si posee una cantidad de ingredientes par, 
//si tiene al menos 100 gr de azúcar y se encuentra en un buen día, 
// que es cuando nivel de habilidad es mayor que 5.
	method puedePrepararPostreFavorito(){
		return self.cantidadPar() && self.azucarSuficiente() && self.buenDia()	
	}
	method cantidadPar() {
		return ingredientes.size().even()
	}
	method azucarSuficiente() {
		return ingredientes.any({ing=>ing.producto() == "azucar" && ing.peso() > 0.1}) 
	}
	method buenDia() {
		return self.habilidad() > 5
	}
//	Se fija en sus ingredientes y los coloca en la cantidad indicada. 
// Si de algún ingrediente no tiene la cantidad requerida, coloca lo que puede y si directamente no lo tiene, no lo pone. 
// La cocina exactamente el tiempo indicado.

	method pruebaTecnica(tortaModelo){
		const nuevaTorta = new Torta(coccion= tortaModelo.coccion(),autor = self)
		tortaModelo.ingredientes().forEach({ing => self.colocarIngrediente(nuevaTorta,ing)})
		jurado.presentarTorta(nuevaTorta)
	}

	method colocarIngrediente(torta, ingrediente) {
		torta.agregarIngrediente(ingrediente.producto(),
			ingrediente.peso().min(self.cuantoTieneDe(ingrediente.producto()))
		) 
	}
	method cuantoTieneDe(producto){
//		return ingredientes.findOrDefault({ing=>ing.producto() == producto},new Ingrediente(producto="")).peso()
		return 
			if(ingredientes.any({ing=>ing.producto() == producto}))
				ingredientes.find({ing=>ing.producto() == producto}).peso()
			else 
				0
	 
	}
	
		
}
//Samanta
//Es muy habilidosa, tiene un nivel de habilidad de 9 aunque no cuenta con ingredientes. 

object samanta {
	method habilidad() {
		return 9
	}
//Nunca puede preparar su postre favorito
	method puedePrepararPostreFavorito() = false

//	Crea una torta sin ingredientes durante 30 minutos, que es su tiempo máximo de atención.
	method pruebaTecnica(tortaModelo){
		jurado.presentarTorta(new Torta(coccion= 30,autor = self))
	}
 
	
}

//Sonia
//Tiene un único ingrediente, que es su favorito. 
//Inicialmente es el chocolate, pero puede cambiarlo por otro 
// o que varíe la cantidad que tiene de él. 
//Podría ser alguno de los que también tiene Marcos o cualquier otro. 
//Además siempre tiene un instrumento de cocina que le trae buena suerte, que puede ser: 

object sonia {
	var property instrumento = cuchara
	const habilidadBase = 1
	var property ingrediente = new Ingrediente(producto="chocolate",peso= 1)

//Su nivel de habilidad es 1 (su habilidad base) más los kilogramos de su ingrediente 
//más la cantidad de suerte de su instrumento de cocina que tiene en ese momento. 
//Como máximo, su habilidad es 10.
	method habilidad(){
		return (habilidadBase +ingrediente.peso() + instrumento.suerte()).min(10) 
	}
	method agregarPeso(peso) {
		ingrediente.aumentarPeso(peso) 
	}
//Puede preparar su postre favorito si tiene chocolate y más de 5 de suerte.
	method puedePrepararPostreFavorito(){
		return ingrediente.producto() == "chocolate" && instrumento.suerte() > 5
	}
	
//	Es muy cuidadosa en las cantidades. Se fija todo lo que la torta pedida requiere y le pone la misma cantidad, 
// pero siempre de su único ingrediente. La cocina el tiempo indicado por 10 dividido su habilidad.
	method pruebaTecnica(tortaModelo){
		jurado.presentarTorta(
			new Torta(
				coccion= tortaModelo.coccion()*10/self.habilidad(),
			    ingredientes = [new Ingrediente(
			    	producto = ingrediente.producto(), 
			    	peso = tortaModelo.pesoTotal()
			    )],
			    autor = self
			)
		)
	}
	
}

//Su cuaderno de recetas, que da 1 de suerte por cada página.
object cuadernoDeRecetas {
	var paginas = 3
	
	method suerte() = paginas
} 

//Una cuchara antigua, que provee 2 de suerte.
object cuchara {
	method suerte() {
		return 2
	}
}

//otro instrumento de cocina que de suerte
object varita{
	method suerte() = 1000 
} 

//Imaginá que te inscribís al programa ¿cómo se calcularía tu nivel habilidad? (evitar soluciones muy triviales o muy complejas)
object yo{
	method habilidad() = (1..100).anyOne()
	method puedePrepararPostreFavorito() = true
}

//
//Nuevamente, falta completar con su propia forma de hacer el postre
//Hacer que todos los participantes entreguen su torta al jurado
//El jurado informa quién es el ganador de la prueba técnica




