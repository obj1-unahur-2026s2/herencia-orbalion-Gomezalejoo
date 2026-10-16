class Tecnologia {
    var property nombre
    var property valorEnergetico
    var property activa 
}
class Equipos {
    var property nombre
    var property nivelDeEnergiaBase
    var property entrenador
    const property tecnologiasComp = []

    method energiaDeTecnologiasActivas() {
        return tecnologiasComp.filter({ t => t.activa() }).sum({ t => t.valorEnergetico() })
    }

    method energiaTotal() = nivelDeEnergiaBase + self.energiaDeTecnologiasActivas()
    method esDePrestigio() = false
}
class Luminicos inherits Equipos{
    const property cristalesSolares = [] 
    var property nivelDeRadiacion  
    override method energiaTotal() {
        const baseConTech = super()
        if (nivelDeRadiacion  < 5000) {
            return baseConTech * 1.10 
        } else {
            return baseConTech
        }
    }

    override method esDePrestigio() =  cristalesSolares.size() >= 3 
                                && self.entrenador().esDeEliteGalactica()
                                && tecnologiasComp.any({t => t.activa()}) 

}

class Sinteticos inherits Equipos {
    var property nivelProcesamiento
    var property cantModulosActivos
    var property estaCertificado 

    override method energiaTotal() {
        const baseConTech = super()
        if (cantModulosActivos > 5) {
            return baseConTech * 0.80 
        } else {
            return baseConTech
        }
    }
    override method esDePrestigio() = estaCertificado && cantModulosActivos > 3 && self.tecnologiasComp().all({t => t.activa()})
}

class Etericos inherits Equipos {
    var property nivelFluctuacion
    var property cantPortalesEnergeticosAbiertos
    override method esDePrestigio() {
        return  nivelFluctuacion > 75 
                && cantPortalesEnergeticosAbiertos >= 2
                && tecnologiasComp.filter({t => t.activa()}).size() >= 2
        }
    override method energiaTotal() {
        const baseConTech = super()
        if (self.esDePrestigio()) {
            return baseConTech * 1.15 
        } else {
            return baseConTech
        }
    }
}

class Entrenadores{
    const property estaEnSintonia
    var property cantCiclosSolares
    var property nivelDePrecision
    var property rol

    method cambiarDeRol(nuevoRol) {
        if (nuevoRol != "Estratega Cuántico" && nuevoRol != "Arquitecto de Energía" && nuevoRol != "Guía Mental") {
            self.error("Rol no homologado por la FOZ")
        }
        rol = nuevoRol
    } 
    method esDeEliteGalactica() {
        return cantCiclosSolares > 10 and self.cumpleCondicionSegunRol()
    }
    
    method cumpleCondicionSegunRol() {
        if (rol == "Estratega Cuántico") {
            return nivelDePrecision > 80
        } else if (rol == "Arquitecto de Energía") {
            return estaEnSintonia
        } else { // Guía Mental
            return true
        }
    }
}

