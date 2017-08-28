local Sets = {}
Sets.Brown = {size=2}
Sets.LightBlue = {size=3}
Sets.Orange = {size=3}
Sets.Red = {size=3}
Sets.Yellow = {size=3}
Sets.Green = {size=3}
Sets.Blue = {size=2}

local Properties = {};

--// Normal properties
Properties[1] = {name="Mediterranean Avenue", price=60, cost=2, set="Brown"}
Properties[2] = {name="Baltic Avenue", price=60, cost=4, set="Brown"}
Properties[4] = {name="Oriental Avenue", price=100, cost=6, set="LightBlue"}
Properties[5] = {name="Vermont Avenue", price=100, cost=6, set="LightBlue"}
Properties[6] = {name="Connecticut Avenue", price=120, cost=8, set="LightBlue"}
Properties[7] = {name="St. Charles Place", price=140, cost=10, set="Pink"}
Properties[8] = {name="States Avenue", price=140, cost=10, set="Pink"}
Properties[9] = {name="Virginia Avenue", price=160, cost=12, set="Pink"}
Properties[10] = {name="St. James Place", price=180, cost=14, set="Orange"}
Properties[11] = {name="Tennessee Avenue", price=180, cost=14, set="Orange"}
Properties[12] = {name="New York Avenue", price=200, cost=16, set="Orange"}
Properties[13] = {name="Kentucky Avenue", price=220, cost=18, set="Red"}
Properties[14] = {name="Indiana Avenue", price=220, cost=18, set="Red"}
Properties[15] = {name="Illinois Avenue", price=240, cost=20, set="Red"}
Properties[16] = {name="Atlantic Avenue", price=260, cost=22, set="Yellow"}
Properties[17] = {name="Ventnor Avenue",  price=260, cost=22, set="Yellow"}
Properties[18] = {name="Marvin Gardens", price=280, cost=24, set="Yellow"}
Properties[19] = {name="Pacific Avenue", price=300, cost=26, set="Green"}
Properties[20] = {name="North Carolina Avenue", price=300, cost=26, set="Green"}
Properties[21] = {name="Pennsylvania Avenue", price=320, cost=28, set="Green"}
Properties[22] = {name="Park Place", price=350, cost=35, set="Blue"}
Properties[23] = {name="Boardwalk", price=400, cost=50, set="Blue"}

local Board = {};
Board[1] = {name="Start", type="static"}
Board[2] = {name="Mediterranean Avenue", type="property", id=1}
Board[3] = {name="Community Chest", type="chest"}
Board[4] = {name="Baltic Avenue", type="property", id=2}
Board[5] = {name="Income Tax", type="tax", cost=200}
Board[6] = {name="Reading Railroad", type="railroad"}
Board[7] = {name="Oriental Avenue", type="property", id=4}
Board[8] = {name="Chance", type="chance"}
Board[9] = {name="Vermont Avenue", type="property", id=5}
Board[10] = {name="Connecticut Avenue", type="property", id=6}
Board[11] = {name="Jail", type="jail", type="jail"}
Board[12] = {name="St. Charles Place", type="property", id=7}
Board[13] = {name="Electric Company", type="company"}
Board[14] = {name="States Avenue", type="property", id=8}
Board[15] = {name="Virginia Avenue", type="property", id=9}
Board[16] = {name="Pennsylvania Railroad", type="railroad"}
Board[17] = {name="St. James Place", type="property", id=10}
Board[18] = {name="Community Chest", type="chest"}
Board[19] = {name="Tennessee Avenue", type="property", id=11}
Board[20] = {name="New York Avenue", type="property", id=12}
Board[21] = {name="Free Parking", type="static"}
Board[22] = {name="Kentucky Avenue", type="property", id=13}
Board[23] = {name="Chance", type="chance"}
Board[24] = {name="Indiana Avenue", type="property", id=14}
Board[25] = {name="Illinois Avenue", type="property", id=15}
Board[26] = {name="B. & O. Railroad", type="railroad"}
Board[27] = {name="Atlantic Avenue", type="property", id=16}
Board[28] = {name="Ventnor Avenue", type="property", id=17}
Board[29] = {name="Water Works", type="company"}
Board[30] = {name="Marvin Gardens", type="property", id=18}
Board[31] = {name="Go To Jail", type="gotojail"}
Board[32] = {name="Pacific Avenue", type="property", id=19}
Board[33] = {name="North Carolina Avenue", type="property", id=20}
Board[34] = {name="Community Chest", type="chest"}
Board[35] = {name="Pennsylvania Avenue", type="property", id=21}
Board[36] = {name="Short Line", type="railroad"}
Board[37] = {name="Chance", type="chance"}
Board[38] = {name="Park Place", type="property", id=22}
Board[39] = {name="Luxury Tax", type="tax", cost=100}
Board[40] = {name="Boardwalk", type="property", id=23}

return {Sets=Sets, Properties=Properties, Board=Board}
