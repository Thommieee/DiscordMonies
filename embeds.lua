local embed = {};

embed.field = function(embed, nme, val, inl)
        table.insert(embed['fields'], {name=nme,value=val,inline=inl})
end

embed.create = function(title, color)
        local embed = {};
        embed['title'] = title;
        embed['color'] = color;
        embed['fields'] = {};
        return embed;
end

return embed;
