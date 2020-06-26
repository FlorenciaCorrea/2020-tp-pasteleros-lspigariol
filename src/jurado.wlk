import pasteleros.*
import tortas.*

object jurado {
	const platos = []
	const participantes = [sonia,marcos,samanta]
	var tortaModelo = tortaWollok

//Cuál es el pastelero más habilidoso del programa
	method masHabilidoso(){
		return participantes.max{part=>part.habilidad()}
	}	
	
//Cuánto más habilidoso es el más habilidoso del programa respecto del menos habilidoso.
	method diferenciaHabilidad(){
		return self.masHabilidoso().habilidad() -
			self.menosHabilidoso().habilidad()
	}
	method menosHabilidoso() {
		return participantes.min{part=>part.habilidad()}
	}

	//Replantear el último ítem del punto anterior, pero considerando sólo los participantes que puedan preparar su postre favorito. 

	method masHabilidosoFavorito(){
		return participantes.filter({part=>part.puedePrepararPostreFavorito()}).max{part=>part.habilidad()}
	}
	
	method presentarTorta(torta){
		platos.add(torta)
	}	
	
	//Cada participante debe elaborar una torta como la pedida, lo mejor que le salga, y presentársela al jurado.
	method realizarPruebaTecnica(){
		participantes.forEach{part=>part.pruebaTecnica(tortaModelo)}
	}
	
	//En una sigilosa investigación descubrimos cómo hace el jurado para determinar al ganador de la prueba técnica. 
	// Para nuestra sorpresa, lo realiza con una simple fórmula: 
	// 10 - (Cantidad de ingredientes de la torta requerida - cantidad de ingredientes utilizados)  - (Tiempo de cocción requerido - Tiempo de cocción empleado). 
	method ganadorPruebaTecnica(){
		return platos.max({plato=>self.puntosPara(plato)}).autor()
	}
	
	method puntosPara(torta){
		return 10 - (torta.pesoTotal()-tortaModelo.pesoTotal()).abs() - (torta.coccion() - tortaModelo.coccion()).abs()
//		return 10 - torta.diferenciaPeso(tortaModelo) - torta.diferenciaCoccion(tortaModelo) 
	}
}


