Concert.create(
  artist: "Bruce Springsteen",
  venue: "Camp Nou",
  city: "Barcelona",
  date: DateTime.new(2016, 05, 14),
  price: 65.00,
  description: "Bruce Springsteen and The E Street Band iniciarán su gira europea en Barcelona el 14 de Mayo, en el Camp Nou. Le seguirán los conciertos de San Sebastián, el 17 de  Mayo en el Estadio de Anoeta y Madrid, el 21 de Mayo en el Estadio Santiago Bernabéu. Tres únicos conciertos en España.",
  asset: File.new("#{Rails.root}/app/assets/images/bruce-springsteen.jpg"),
)
Concert.create(
  artist: "Paul McCartney",
  venue: "Estadio Vicente Calderón",
  city: "Madrid",
  date: DateTime.new(2016, 06, 02),
  price: 101.00,
  description: "Paul McCartney, que ofreció su último concierto en España hace doce años, presentará en Madrid y en otros países como Estados Unidos o Alemania su gira “One on one”,  precedida por el éxito de “Out there”, su anterior tour que finalizó en octubre de 2015 recorriendo 22 ciudades con 27 shows."
)
Concert.create(
  artist: "Estopa",
  venue: "Palau Sant Jorid",
  city: "Barcelona",
  date: DateTime.new(2016, 10, 15),
  price: 39.00,
  description: "Estopa vuelve a los escenario para presentar su nuevo disco “Rumba a lo desconocido” cuyo primer single “Pastillas para dormir” se ha convertido en todo un éxito desde su lanzamiento."
)
Concert.create(
  artist: "Azkena Rock Festival 16",
  venue: "Recinto Mendizabala",
  city: "Vitoria",
  date: DateTime.new(2016, 06, 17),
  price: 95.00,
  description: "El Azkena Rock Festival, que se celebrará los próximo 17 y 18 de junio en Mendizabala, sigue avanzando nombres de su cartel: The Who, Refused, 091 y Daniel Romano se suman ahora a los ya anunciados Blackberry Smoke, Radio Birdman y Buffalo Killers."
)
Concert.create(
  artist: "Celtas Cortos",
  venue: "Auditorio Manuel de Falla",
  city: "Granada",
  date: DateTime.new(2016, 04, 30),
  price: 24.80,
  description: "Celtas Cortos llega a Granada con su nuevo CD de temas propios. Seis años en los que los de tierra de vinos han macerado en su barrica las mejores composiciones."
)
