!classDefinition: #AvispaOriana category: 'AvispasYAbejasParte2'!
DenotativeObject subclass: #AvispaOriana
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AvispasYAbejasParte2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AvispaOriana class' category: 'AvispasYAbejasParte2'!
AvispaOriana class
	instanceVariableNames: ''!

!AvispaOriana class methodsFor: 'as yet unclassified' stamp: 'GF 4/23/2022 10:36:56'!
intentarReproducirse
	(Habitat cantidadDeOrugas > 0) ifTrue: [
		Habitat reducirCantidadDeOrugas.
		Habitat aumentarCantidadDeHuevosConLaFirmaGeneticaDeOrianaYOrnella.
	]
		
! !


!classDefinition: #AvispaLara category: 'AvispasYAbejasParte2'!
AvispaOriana subclass: #AvispaLara
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AvispasYAbejasParte2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AvispaLara class' category: 'AvispasYAbejasParte2'!
AvispaLara class
	instanceVariableNames: ''!

!AvispaLara class methodsFor: 'as yet unclassified' stamp: 'jf 4/24/2022 12:21:44'!
intentarReproducirse
	| diccionarioDeHuevosConFirmasGeneticas |
	diccionarioDeHuevosConFirmasGeneticas := Habitat diccionarioDeHuevosDeAvispas.
	
	((diccionarioDeHuevosConFirmasGeneticas at: 'AvispaOrianaYOrnella') > 0) ifTrue: [
		Habitat reducirCantidadDeHuevosConLaFirmaGeneticaDeOrianaYOrnella.
		Habitat aumentarCantidadDeHuevosConLaFirmaGeneticaDeLara.
		^self.
	].

	((diccionarioDeHuevosConFirmasGeneticas at: 'AvispaPolly') > 0) ifTrue: [
		Habitat reducirCantidadDeHuevosConLaFirmaGeneticaDePolly.
		Habitat aumentarCantidadDeHuevosConLaFirmaGeneticaDeLara.
	].! !


!classDefinition: #AvispaOrnella category: 'AvispasYAbejasParte2'!
AvispaOriana subclass: #AvispaOrnella
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AvispasYAbejasParte2'!


!classDefinition: #AvispaPolly category: 'AvispasYAbejasParte2'!
AvispaOriana subclass: #AvispaPolly
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AvispasYAbejasParte2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AvispaPolly class' category: 'AvispasYAbejasParte2'!
AvispaPolly class
	instanceVariableNames: ''!

!AvispaPolly class methodsFor: 'as yet unclassified' stamp: 'GF 4/23/2022 10:37:02'!
intentarReproducirse
	(Habitat cantidadDePolillas > 0) ifTrue: [
		Habitat reducirCantidadDePolillas.
		Habitat aumentarCantidadDeHuevosConLaFirmaGeneticaDePolly.
	]! !


!classDefinition: #Habitat category: 'AvispasYAbejasParte2'!
DenotativeObject subclass: #Habitat
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AvispasYAbejasParte2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Habitat class' category: 'AvispasYAbejasParte2'!
Habitat class
	instanceVariableNames: 'diccionarioDeHuevosDeAvispas cantidadDePolillas cantidadDeOrugas'!

!Habitat class methodsFor: 'orugas' stamp: 'jf 4/22/2022 18:26:23'!
aumentarCantidadDeOrugas
	cantidadDeOrugas := cantidadDeOrugas + 1.! !

!Habitat class methodsFor: 'orugas' stamp: 'jf 4/24/2022 23:23:29'!
cantidadDeOrugas
	^cantidadDeOrugas.! !

!Habitat class methodsFor: 'orugas' stamp: 'jf 4/24/2022 23:24:06'!
reducirCantidadDeOrugas
	cantidadDeOrugas := cantidadDeOrugas - 1.! !


!Habitat class methodsFor: 'huevosDeAvispas' stamp: 'GF 4/23/2022 10:52:41'!
cantidadDeHuevosDeAvispas
	^diccionarioDeHuevosDeAvispas sum: [: Huevo | Huevo] ifEmpty: [0].! !

!Habitat class methodsFor: 'huevosDeAvispas' stamp: 'GF 4/23/2022 10:53:36'!
diccionarioDeHuevosDeAvispas
	^diccionarioDeHuevosDeAvispas.! !


!Habitat class methodsFor: 'polillas' stamp: 'jf 4/22/2022 18:43:45'!
aumentarCantidadDePolillas
	cantidadDePolillas := cantidadDePolillas + 1.! !

!Habitat class methodsFor: 'polillas' stamp: 'jf 4/22/2022 18:27:49'!
cantidadDePolillas
	^cantidadDePolillas.! !

!Habitat class methodsFor: 'polillas' stamp: 'jf 4/22/2022 19:39:48'!
reducirCantidadDePolillas
	cantidadDePolillas := cantidadDePolillas  - 1.! !


!Habitat class methodsFor: 'restablecimiento' stamp: 'jf 4/24/2022 23:24:21'!
restablecerCantidadDeOrugas
	cantidadDeOrugas := 0.! !

!Habitat class methodsFor: 'restablecimiento' stamp: 'jf 4/22/2022 18:45:42'!
restablecerCantidadDePolillas
	cantidadDePolillas := 0.! !

!Habitat class methodsFor: 'restablecimiento' stamp: 'jf 4/24/2022 11:43:06'!
restablecerHabitat
	self restablecerCantidadDeOrugas.
	self restablecerCantidadDePolillas.
	self restablecerHuevosConFirmasGeneticas.
	
! !

!Habitat class methodsFor: 'restablecimiento' stamp: 'GF 4/23/2022 10:53:15'!
restablecerHuevosConFirmasGeneticas
	diccionarioDeHuevosDeAvispas at: 'AvispaOrianaYOrnella' put: 0.
	diccionarioDeHuevosDeAvispas at: 'AvispaPolly' put: 0.
	diccionarioDeHuevosDeAvispas at: 'AvispaLara' put: 0.! !


!Habitat class methodsFor: 'orianaYOrnella' stamp: 'GF 4/23/2022 10:52:27'!
aumentarCantidadDeHuevosConLaFirmaGeneticaDeOrianaYOrnella
	| huevosConLaFirmaGeneticaDeOrianaYOrnella |
	huevosConLaFirmaGeneticaDeOrianaYOrnella := diccionarioDeHuevosDeAvispas at: 'AvispaOrianaYOrnella'.
	diccionarioDeHuevosDeAvispas at: 'AvispaOrianaYOrnella' put: (huevosConLaFirmaGeneticaDeOrianaYOrnella + 1).! !

!Habitat class methodsFor: 'orianaYOrnella' stamp: 'GF 4/23/2022 10:52:37'!
cantidadDeHuevosConLaFirmaGeneticaDeOrianaYOrnella
	^diccionarioDeHuevosDeAvispas at: 'AvispaOrianaYOrnella'.! !

!Habitat class methodsFor: 'orianaYOrnella' stamp: 'GF 4/23/2022 10:52:50'!
reducirCantidadDeHuevosConLaFirmaGeneticaDeOrianaYOrnella
	| huevosConLaFirmaGeneticaDeOrianaYOrnella |
	huevosConLaFirmaGeneticaDeOrianaYOrnella := diccionarioDeHuevosDeAvispas at: 'AvispaOrianaYOrnella'.
	diccionarioDeHuevosDeAvispas at: 'AvispaOrianaYOrnella' put: (huevosConLaFirmaGeneticaDeOrianaYOrnella - 1).! !


!Habitat class methodsFor: 'polly' stamp: 'GF 4/23/2022 10:52:31'!
aumentarCantidadDeHuevosConLaFirmaGeneticaDePolly
	| huevosConLaFirmaGeneticaDePolly |
	huevosConLaFirmaGeneticaDePolly := diccionarioDeHuevosDeAvispas at: 'AvispaPolly'.
	diccionarioDeHuevosDeAvispas at: 'AvispaPolly' put: (huevosConLaFirmaGeneticaDePolly + 1).! !

!Habitat class methodsFor: 'polly' stamp: 'GF 4/23/2022 10:52:39'!
cantidadDeHuevosConLaFirmaGeneticaDePolly
	^diccionarioDeHuevosDeAvispas at: 'AvispaPolly'.! !

!Habitat class methodsFor: 'polly' stamp: 'jf 4/24/2022 11:32:33'!
reducirCantidadDeHuevosConLaFirmaGeneticaDePolly
	| huevosConLaFirmaGeneticaDePolly |
	huevosConLaFirmaGeneticaDePolly := diccionarioDeHuevosDeAvispas at: 'AvispaPolly'.
	diccionarioDeHuevosDeAvispas at: 'AvispaPolly' put: (huevosConLaFirmaGeneticaDePolly - 1).! !


!Habitat class methodsFor: 'lara' stamp: 'GF 4/23/2022 10:52:24'!
aumentarCantidadDeHuevosConLaFirmaGeneticaDeLara
	| huevosConLaFirmaGeneticaDeLara |
	huevosConLaFirmaGeneticaDeLara := diccionarioDeHuevosDeAvispas at: 'AvispaLara'.
	diccionarioDeHuevosDeAvispas at: 'AvispaLara' put: (huevosConLaFirmaGeneticaDeLara + 1).
	
	! !

!Habitat class methodsFor: 'lara' stamp: 'GF 4/23/2022 10:52:35'!
cantidadDeHuevosConLaFirmaGeneticaDeLara
	^diccionarioDeHuevosDeAvispas at: 'AvispaLara'.! !

!Habitat class methodsFor: 'lara' stamp: 'GF 4/23/2022 10:52:45'!
reducirCantidadDeHuevosConLaFirmaGeneticaDeLara
	| huevosConLaFirmaGeneticaDeLara |
	huevosConLaFirmaGeneticaDeLara := diccionarioDeHuevosDeAvispas at: 'AvispaLara'.
	diccionarioDeHuevosDeAvispas at: 'AvispaLara' put: (huevosConLaFirmaGeneticaDeLara - 1).! !


!Habitat class methodsFor: '--** private fileout/in **--' stamp: 'jf 4/24/2022 23:25:20'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	diccionarioDeHuevosDeAvispas := ((Dictionary new) add: ('AvispaLara'->0); add: ('AvispaOrianaYOrnella'->2); add: ('AvispaPolly'->0); yourself).
	cantidadDePolillas := 1.
	cantidadDeOrugas := 0.! !


!classDefinition: #PruebasReproduccionDeAvispas category: 'AvispasYAbejasParte2'!
DenotativeObject subclass: #PruebasReproduccionDeAvispas
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AvispasYAbejasParte2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PruebasReproduccionDeAvispas class' category: 'AvispasYAbejasParte2'!
PruebasReproduccionDeAvispas class
	instanceVariableNames: ''!

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Oriana' stamp: 'JMB 4/18/2022 18:38:11'!
test01EnElInicioDeLosTiemposNoHayHuevos	
	self retrocederElHabitatAlInicioDeLosTiempos.
	
	Assert that: self habitat cantidadDeHuevosDeAvispas isEqualTo: 0! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Oriana' stamp: 'JMB 4/21/2022 12:12:44'!
test02CuandoOrianaLaAvispaSeReproducePorPrimeraVezDejaUnHuevo
	self retrocederElHabitatAlInicioDeLosTiempos. 
	self hacerQueElHabitatTengaLosRecursosSuficientes.
	
	self laAvispaOriana intentarReproducirse.
	
	Assert that: self habitat cantidadDeHuevosDeAvispas isEqualTo: 1.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Oriana' stamp: 'JMB 4/21/2022 12:12:11'!
test03CadaVezQueOrianaSeReproduceDejaUnHuevoMas
	self retrocederElHabitatAlInicioDeLosTiempos. 
	self hacerQueElHabitatTengaLosRecursosSuficientes.
	self laAvispaOriana intentarReproducirse.
	
	self laAvispaOriana intentarReproducirse.
	
	Assert that: self habitat cantidadDeHuevosDeAvispas isEqualTo: 2.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Oriana' stamp: 'JMB 4/21/2022 12:12:53'!
test04ParaDejarUnHuevoOrianaLaAvispaReduceLaPoblacionDeUnaOrugaANinguna
	self retrocederElHabitatAlInicioDeLosTiempos.
	self queElHabitatTengaUnaOrugaMas.
	
	self laAvispaOriana intentarReproducirse.
	
	Assert that: self habitat cantidadDeOrugas isEqualTo: 0.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Oriana' stamp: 'JMB 4/21/2022 12:13:43'!
test05ParaDejarUnHuevoOrianaLaAvispaDecrementaEnUnoLaPoblacionDeOrugasDelHabitat
	self retrocederElHabitatAlInicioDeLosTiempos.
	self queElHabitatTengaDosOrugasMas.
	
	self laAvispaOriana intentarReproducirse.
	
	Assert that: self habitat cantidadDeOrugas isEqualTo: 1.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Oriana' stamp: 'JMB 4/21/2022 12:13:22'!
test06CuandoNoHayOrugasOrianaLaAvispaNoPuedeDejarHuevos
	self retrocederElHabitatAlInicioDeLosTiempos.
	
	self laAvispaOriana intentarReproducirse.
	
	Assert that: self habitat cantidadDeHuevosDeAvispas isEqualTo: 0.! !


!PruebasReproduccionDeAvispas class methodsFor: 'tests - Ornella' stamp: 'JMB 4/21/2022 12:14:24'!
test07CuandoOrnellaLaAvispaSeReproduceDejaUnHuevo
	self retrocederElHabitatAlInicioDeLosTiempos. 
	self hacerQueElHabitatTengaLosRecursosSuficientes.
	
	self laAvispaOrnella intentarReproducirse.
	
	Assert that: self habitat cantidadDeHuevosDeAvispas isEqualTo: 1.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Ornella' stamp: 'JMB 4/21/2022 12:14:18'!
test08ParaDejarUnHuevoOrnellaLaAvispaReduceLaPoblacionDeUnaOrugaANinguna
	self retrocederElHabitatAlInicioDeLosTiempos.
	self queElHabitatTengaUnaOrugaMas.
	
	self laAvispaOrnella intentarReproducirse.
	
	Assert that: self habitat cantidadDeOrugas isEqualTo: 0.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Ornella' stamp: 'JMB 4/21/2022 12:14:11'!
test09CuandoNoHayOrugasOrnellaLaAvispaNoPuedeDejarHuevos
	self retrocederElHabitatAlInicioDeLosTiempos.
	
	self laAvispaOrnella intentarReproducirse.
	
	Assert that: self habitat cantidadDeHuevosDeAvispas isEqualTo: 0.! !


!PruebasReproduccionDeAvispas class methodsFor: 'tests - Polly' stamp: 'JMB 4/21/2022 12:14:46'!
test10CuandoPollyLaAvispaSeReproduceDejaUnHuevo
	self retrocederElHabitatAlInicioDeLosTiempos. 
	self hacerQueElHabitatTengaLosRecursosSuficientes.
	
	self laAvispaPolly intentarReproducirse.
	
	Assert that: self habitat cantidadDeHuevosDeAvispas isEqualTo: 1.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Polly' stamp: 'JMB 4/21/2022 12:14:40'!
test11ParaDejarUnHuevoPollyLaAvispaReduceLaPoblacionDeUnaPolillaANinguna
	self retrocederElHabitatAlInicioDeLosTiempos.
	self queElHabitatTengaUnaPolillaMas.
	
	self laAvispaPolly intentarReproducirse.
	
	Assert that: self habitat cantidadDePolillas isEqualTo: 0.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Polly' stamp: 'JMB 4/21/2022 12:14:36'!
test12ParaDejarUnHuevoPollyLaAvispaDecrementaEnUnoLaPoblacionDePolillasDelHabitat
	self retrocederElHabitatAlInicioDeLosTiempos.
	self queElHabitatTengaDosPolillasMas.
	
	self laAvispaPolly intentarReproducirse.
	
	Assert that: self habitat cantidadDePolillas isEqualTo: 1.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Polly' stamp: 'JMB 4/21/2022 12:14:30'!
test13CuandoNoHayPolillasPollyLaAvispaNoPuedeDejarHuevos
	self retrocederElHabitatAlInicioDeLosTiempos.
	
	self laAvispaPolly intentarReproducirse.
	
	Assert that: self habitat cantidadDeHuevosDeAvispas isEqualTo: 0.! !


!PruebasReproduccionDeAvispas class methodsFor: 'tests - firma genetica' stamp: 'JMB 4/21/2022 12:15:06'!
test14CuandoOrianaLaAvispaSeReproduceDejaUnHuevoConSuFirmaGenetica
	self retrocederElHabitatAlInicioDeLosTiempos. 
	self hacerQueElHabitatTengaLosRecursosSuficientes.
	
	self laAvispaOriana intentarReproducirse.
	
	Assert that: self cantidadDeHuevosConLaFirmaGeneticaDeOriana isEqualTo: 1.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - firma genetica' stamp: 'JMB 4/21/2022 12:15:02'!
test15CuandoOrianaLaAvispaAunNoSeReprodujoNoTieneHuevosConSuFirmaGenetica
	self retrocederElHabitatAlInicioDeLosTiempos. 
	
	self laAvispaOriana intentarReproducirse.
	
	Assert that: self cantidadDeHuevosConLaFirmaGeneticaDeOriana isEqualTo: 0.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - firma genetica' stamp: 'JMB 4/21/2022 12:14:58'!
test16CuandoPollyLaAvispaSeReproduceDejaUnHuevoConSuFirmaGenetica
	self retrocederElHabitatAlInicioDeLosTiempos. 
	self hacerQueElHabitatTengaLosRecursosSuficientes.
	
	self laAvispaPolly intentarReproducirse.
	
	Assert that: self cantidadDeHuevosConLaFirmaGeneticaDePolly isEqualTo: 1.
	Assert that: self cantidadDeHuevosConLaFirmaGeneticaDeOriana isEqualTo: 0.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - firma genetica' stamp: 'jf 4/22/2022 19:24:45'!
test17CuandoOrnellaLaAvispaSeReproduceDejaUnHuevoConLaMismaFirmaGeneticaQueOriana
	self retrocederElHabitatAlInicioDeLosTiempos. 
	self hacerQueElHabitatTengaLosRecursosSuficientes.
	
	self laAvispaOrnella intentarReproducirse.
	
	Assert that: self cantidadDeHuevosConLaFirmaGeneticaDeOrnella isEqualTo: 1.
	Assert that: self cantidadDeHuevosConLaFirmaGeneticaDeOrnella isEqualTo: self cantidadDeHuevosConLaFirmaGeneticaDeOriana! !


!PruebasReproduccionDeAvispas class methodsFor: 'tests - Lara la ladrona' stamp: 'JMB 4/21/2022 12:15:27'!
test18CuandoLaraLaAvispaSeReproduceDejaUnHuevoConSuFirmaGenetica
	self retrocederElHabitatAlInicioDeLosTiempos. 
	self hacerQueElHabitatTengaLosRecursosSuficientes.
	self laAvispaOrnella intentarReproducirse.
	
	self laAvispaLara intentarReproducirse.
	
	Assert that: self cantidadDeHuevosConLaFirmaGeneticaDeLara isEqualTo: 1.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Lara la ladrona' stamp: 'JMB 4/21/2022 12:15:22'!
test19CuandoLaraLaAvispaSeReproduceLeSacaElHuevoAOtraAvispa
	self retrocederElHabitatAlInicioDeLosTiempos. 
	self hacerQueElHabitatTengaLosRecursosSuficientes.
	self laAvispaOriana intentarReproducirse.
	
	self laAvispaLara intentarReproducirse.
	
	Assert that: self cantidadDeHuevosConLaFirmaGeneticaDeOriana isEqualTo: 0.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Lara la ladrona' stamp: 'JMB 4/21/2022 12:15:18'!
test20CuandoLaraLaAvispaSeReproduceLeSacaElHuevoAPolly
	self retrocederElHabitatAlInicioDeLosTiempos. 
	self hacerQueElHabitatTengaLosRecursosSuficientes.
	self laAvispaPolly intentarReproducirse.
	
	self laAvispaLara intentarReproducirse.
	
	Assert that: self cantidadDeHuevosConLaFirmaGeneticaDePolly isEqualTo: 0.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Lara la ladrona' stamp: 'JMB 4/21/2022 12:15:12'!
test21CuandoLaraLaAvispaNoTieneRecursosNoDejaUnHuevo
	self retrocederElHabitatAlInicioDeLosTiempos. 
		
	self laAvispaLara intentarReproducirse.
		
	Assert that: self cantidadDeHuevosConLaFirmaGeneticaDeLara isEqualTo: 0.! !


!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'jf 4/24/2022 11:07:40'!
cantidadDeHuevosConLaFirmaGeneticaDeLara
	^self habitat cantidadDeHuevosConLaFirmaGeneticaDeLara.
	! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'jf 4/24/2022 11:07:47'!
cantidadDeHuevosConLaFirmaGeneticaDeOriana
	^self habitat cantidadDeHuevosConLaFirmaGeneticaDeOrianaYOrnella.! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'jf 4/24/2022 11:07:51'!
cantidadDeHuevosConLaFirmaGeneticaDeOrnella
	^self habitat cantidadDeHuevosConLaFirmaGeneticaDeOrianaYOrnella.! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'jf 4/24/2022 11:07:55'!
cantidadDeHuevosConLaFirmaGeneticaDePolly
	^self habitat cantidadDeHuevosConLaFirmaGeneticaDePolly.! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'jf 4/24/2022 11:06:30'!
habitat
	^Habitat! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'jf 4/22/2022 18:42:19'!
hacerQueElHabitatTengaLosRecursosSuficientes
	self queElHabitatTengaDosOrugasMas.
	self queElHabitatTengaUnaPolillaMas.! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'jf 4/22/2022 19:38:03'!
laAvispaLara
	^AvispaLara.! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'GMF 4/21/2022 19:48:09'!
laAvispaOriana
	^AvispaOriana! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'jf 4/22/2022 18:17:46'!
laAvispaOrnella
	^AvispaOrnella.
! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'jf 4/22/2022 18:38:10'!
laAvispaPolly
	^AvispaPolly.! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'jf 4/24/2022 11:08:07'!
queElHabitatTengaDosOrugasMas
	2 timesRepeat: [self habitat aumentarCantidadDeOrugas].! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'jf 4/24/2022 11:08:13'!
queElHabitatTengaDosPolillasMas
	2 timesRepeat: [self habitat aumentarCantidadDePolillas].! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'jf 4/24/2022 11:08:17'!
queElHabitatTengaUnaOrugaMas
	self habitat aumentarCantidadDeOrugas.! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'jf 4/24/2022 11:08:21'!
queElHabitatTengaUnaPolillaMas
	self habitat aumentarCantidadDePolillas.! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'jf 4/24/2022 11:08:24'!
retrocederElHabitatAlInicioDeLosTiempos
	self habitat restablecerHabitat.! !

Habitat initializeAfterFileIn!