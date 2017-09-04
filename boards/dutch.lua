local Sets = {}
Sets.Bruin = {size=2}
Sets.LichtBlauw = {size=3}
Sets.Oranje = {size=3}
Sets.Rood = {size=3}
Sets.Geel = {size=3}
Sets.Groen = {size=3}
Sets.Blauw = {size=2}
Sets.Station = {size=4}
local Properties = {};

--// Normal properties
Properties[1] = {name="Bruin 1", price=60, cost=2, set="Bruin"}
Properties[2] = {name="Bruin 2", price=60, cost=4, set="Bruin"}
Properties[4] = {name="Licht Blauw 1", price=100, cost=6, set="LichtBlauw"}
Properties[5] = {name="Licht Blauw 2", price=100, cost=6, set="LichtBlauw"}
Properties[6] = {name="Licht Blauw 3", price=120, cost=8, set="LichtBlauw"}
Properties[7] = {name="Roze 1", price=140, cost=10, set="Roze"}
Properties[8] = {name="Roze 2", price=140, cost=10, set="Roze"}
Properties[9] = {name="Roze 3", price=160, cost=12, set="Roze"}
Properties[10] = {name="Oranje 1", price=180, cost=14, set="Oranje"}
Properties[11] = {name="Oranje 2", price=180, cost=14, set="Oranje"}
Properties[12] = {name="Oranje 3", price=200, cost=16, set="Oranje"}
Properties[13] = {name="Rood 1", price=220, cost=18, set="Rood"}
Properties[14] = {name="Rood 2", price=220, cost=18, set="Rood"}
Properties[15] = {name="Rood 3", price=240, cost=20, set="Rood"}
Properties[16] = {name="Geel 1", price=260, cost=22, set="Geel"}
Properties[17] = {name="Geel 2",  price=260, cost=22, set="Geel"}
Properties[18] = {name="Geel 3", price=280, cost=24, set="Geel"}
Properties[19] = {name="Groen 1", price=300, cost=26, set="Groen"}
Properties[20] = {name="Groen 2", price=300, cost=26, set="Groen"}
Properties[21] = {name="Groen 3", price=320, cost=28, set="Groen"}
Properties[22] = {name="Blauw 1", price=350, cost=35, set="Blauw"}
Properties[23] = {name="Blauw 2", price=400, cost=50, set="Blauw"}
Properties[24] = {name="Station Zuid", price=200, set="Station"}
Properties[25] = {name="Station Noord", price=200, set="Station"}
Properties[26] = {name="Station Oost", price=200, set="Station"}
Properties[27] = {name="Station West", price=200, set="Station"}
Properties[28] = {name="Elektriciteitsbedrijf", price=150, set="Utility"}
Properties[29] = {name="Waterleidingsbedrijf", price=150, set="Utility"}

local Board = {};
Board[1] = {name="Start", type="static"}
Board[2] = {name="Bruin 1", type="property", id=1}
Board[3] = {name="Algemeen Fonds 1", type="chest"}
Board[4] = {name="Bruin 2", type="property", id=2}
Board[5] = {name="Inkomstenbelasting", type="tax", cost=200}
Board[6] = {name="Station Zuid", type="railroad", id=24}
Board[7] = {name="Licht Blauw 1", type="property", id=4}
Board[8] = {name="Kans 1", type="chance"}
Board[9] = {name="Licht Blauw 2", type="property", id=5}
Board[10] = {name="Licht Blauw 3", type="property", id=6}
Board[11] = {name="Gevangenis", type="jail", type="jail"}
Board[12] = {name="Roze 1", type="property", id=7}
Board[13] = {name="Elektriciteitsbedrijf", type="company", id=28}
Board[14] = {name="Roze 2", type="property", id=8}
Board[15] = {name="Roze 3", type="property", id=9}
Board[16] = {name="Station West", type="railroad", id=27}
Board[17] = {name="Oranje 1", type="property", id=10}
Board[18] = {name="Algemeen Fonds 2", type="chest"}
Board[19] = {name="Oranje 2", type="property", id=11}
Board[20] = {name="Oranje 3", type="property", id=12}
Board[21] = {name="Vrij Parking", type="static"}
Board[22] = {name="Rood 1", type="property", id=13}
Board[23] = {name="Kans 2", type="chance"}
Board[24] = {name="Rood 2", type="property", id=14}
Board[25] = {name="Rood 3", type="property", id=15}
Board[26] = {name="Station Noord", type="railroad", id=25}
Board[27] = {name="Geel 1", type="property", id=16}
Board[28] = {name="Geel 2", type="property", id=17}
Board[29] = {name="Waterleidingsbedrijf", type="company", id=29}
Board[30] = {name="Geel 3", type="property", id=18}
Board[31] = {name="Naar De Gevangenis", type="gotojail"}
Board[32] = {name="Groen 1", type="property", id=19}
Board[33] = {name="Groen 2", type="property", id=20}
Board[34] = {name="Algemeen Fonds 3", type="chest"}
Board[35] = {name="Groen 3", type="property", id=21}
Board[36] = {name="Station Oost", type="railroad", id=26}
Board[37] = {name="Kans 3", type="chance"}
Board[38] = {name="Blauw 1", type="property", id=22}
Board[39] = {name="Extra Belasting", type="tax", cost=100}
Board[40] = {name="Blauw 2", type="property", id=23}

local Chance = {};
Chance[0] = "Ga naar Start (Ontvang $200)"
Chance[1] = "Ga naar Rood 3. Als je langs start komt, ontvang je $200"
Chance[2] = "Ga naar Roze 1. Als je langs start komt, ontvang je $200"
Chance[3] = "Ga verder naar het dichtstbijzijnde nutbedrijf. Als het niet verkocht is, mag je het kopen van de bank. Als het wel gekocht is, gooi je een dobbelsteen en betaal je de eigenaar 10 keer het aantal ogen van je worp."
Chance[4] = "Ga verder naar het dichtstbijzijnde station. Als het niet verkocht is, mag je het kopen van de bank. Als het wel gekocht is, betaal je de eigenaar twee maal de huur waar hij/zij recht op heeft."
Chance[5] = "Ga verder naar het dichtstbijzijnde station. Als het niet verkocht is, mag je het kopen van de bank. Als het wel gekocht is, betaal je de eigenaar twee maal de huur waar hij/zij recht op heeft."
Chance[6] = "De bank betaalt je dividend. Je krijgt $50"
Chance[7] = "Ga direct naar de gevangenis. Ga niet langs Start, je krijgt geen $200"
Chance[8] = "Ga drie vakjes terug"
Chance[9] = "Repareer al je huizen en hotels. Voor elk huis betaal je $25, voor elk hotel betaal je $100."
Chance[10] = "Boete voor te snel rijden. - Betaal $15"
Chance[11] = "Ga verder naar Station Noord, als je langst start komt, krijg je $200"
Chance[12] = "Ga verder naar Blauw 2"
Chance[13] = "Je bent gekozen tot bestuursvoorzitter - Betaal elke speler $50"
Chance[14] = "Your bouwverzekering vervalt - Je krijgt $150"

Chest = {};

Chest[0] = "Ga naar Start (Je krijgt $200)"
Chest[1] = "Vergissing van de bank in jouw voordeel. Je krijgt $200"
Chest[2] = "Betaal het ziekenhuis - Betaal $100"
Chest[3] = "Je verkoopt aandelen - Je krijgt $50"
Chest[4] = "Ga direct naar de gevangenis. Ga niet langs Start, je krijgt geen $200"
Chest[6] = "Uitkering Vakantiegeld - Je krijgt $100"
Chest[7] = "Teruggave Inkomstenbelasting - Je krijgt $20"
Chest[8] = "Je bent jarig. Ontvang $10 van elke speler."
Chest[9] = "Je levensverzekering betaalt uit - Je krijgt $100"
Chest[10] = "Betaal je doktersrekening - Betaal $50"
Chest[11] = "Betaal schoolgeld. - Betaal $150"
Chest[12] = "Adviezen Gegeven. - Je krijgt $25"
Chest[13] = "Renoveer al je huizen en hotels - Betaal $40 per huis - $115 per hotel"
Chest[14] = "Je wint de tweede prijs in een schoonheidswedstrijd - Je krijgt $10"
Chest[5] = "Een erfenis - Je krijgt $100"


return {Sets=Sets, Properties=Properties, Board=Board, Chance=Chance, Chest=Chest}
