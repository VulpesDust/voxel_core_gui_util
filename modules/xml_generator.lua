local this = {}

function this.generate(args)
    if args.label then
        return string.format('<%s %s>%s</%s>', args.tag, args.attributes, args.label, args.tag)
    else
        return string.format('<%s %s/>', args.tag, args.attributes)
    end
end

return this
