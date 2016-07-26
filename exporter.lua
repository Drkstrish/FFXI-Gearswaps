lor_gs_versions.exporter = '2016-07-16.0'

--[[
    Figure out how this works exactly since im not sure.
    
    Export Gear
    Exports the currently equipped gear in proper lua format to 
    Windower/addons/GearSwap/data/export/Playername_JOB_timestamp.lua
    Arguments, providable in any order:
    list        prints each item on a separate line (default is grouped)
    <set name>  uses the provided name as the name of the set
--]]
local _export_gear = function(args)
    local header = 'sets.exported'
    local listfmt = not any_eq('no_augs', unpack(args))
    local include_augs = true
    --Process provided arguments
    for _,arg in pairs(args) do
        if arg:lower() == 'list' then
            listfmt = true
        elseif arg:lower() == 'group' then
            listfmt = false
        elseif arg:lower() == 'no_augs' then
            include_augs = false
        elseif arg:lower() == 'help' then
            atc('Usage: //gs c export [list] [no_augs] <set_name>')
            atc('list:     print each item on a separate line')
            atc('group:    print items grouped by equipment window rows')
            atc('no_augs:  only include item names, not augments (default: include augments)')
            atc('set name: name to use for the set (default: %s)':format(header))
            return
        else
            header = arg
        end
    end
    
    --Process currently equipped gear
    local slots = {'main','sub','range','ammo','head','neck','left_ear','right_ear','body','hands','left_ring','right_ring','back','waist','legs','feet'}
    local slotmap = {['left_ear']='ear1',['right_ear']='ear2',['left_ring']='ring1',['right_ring']='ring2'}
    local bagmap = {[0]='inventory',[8]='wardrobe',[10]='wardrobe2',[11]='wardrobe3',[12]='wardrobe4'}
    local itemlist = windower.ffxi.get_items()
    local eq_tbl = itemlist.equipment
    
    local enquote = customized(string.format, "'%s'")
    
    local equipped = {}
    for _,slot in pairs(slots) do
        local idx_in_bag = eq_tbl[slot]
        if (idx_in_bag ~= 0) then
            local sname = slotmap[slot] or slot
            local uniq_item = itemlist[bagmap[eq_tbl[slot..'_bag']]][idx_in_bag]
            local iname = '"%s"':format(res.items[uniq_item.id].enl:capitalize())
            uniq_item = setops.expand_augments(uniq_item)
            if include_augs and (#uniq_item.augments > 0) then
                equipped[sname] = '{name=%s, augments=%s}':format(iname, '{%s}':format(',':join(map(enquote, uniq_item.augments))))
            else
                equipped[sname] = iname
            end
        end
    end

    --  ==========  Write the file      ==========

    if not windower.dir_exists(windower.addon_path..'data/export') then
        windower.create_dir(windower.addon_path..'data/export')
    end
    
    local path = 'data/export/'..player.name
    path = path..os.date('_%Y.%m.%d_%H.%M.%S')
    path = path..'_'..windower.ffxi.get_player().main_job
    if windower.file_exists(path..'.lua') then
        path = path..' '..os.clock()
    end
    
    local f = io.open(windower.addon_path..path..'.lua','w+')
    f:write(header..' = {\n')
    
    local fmt = '\t%s=%s'
    local printed = 0
    local last_comma = sizeof(equipped)
    local comma = false
    local last_was_nl = false
    for i = 1, 16 do
        local slot = slots[i]
        local sname = slotmap[slot] or slot
        local iname = equipped[sname]
        
        if comma then f:write(',') end
        if iname then
            f:write(fmt:format(sname, iname))
            printed = printed + 1
            comma = printed < last_comma
            last_was_nl = false
        else
            comma = false
        end
        
        if listfmt or (i % 4 == 0) then
            if comma then f:write(',') end
            if not last_was_nl then
                f:write('\n')
                last_was_nl = true
            end
            comma = false
        end
    end
    
    f:write('}')
    f:close()
    atc('Successfully exported set to '..path..'.lua')
end

export_gear = traceable(_export_gear)
