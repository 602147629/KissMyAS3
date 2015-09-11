class mx.data.kinds.Data extends mx.data.binding.DataAccessor
{
    var location, property, component;
    function Data()
    {
        super();
    } // End of the function
    function getTypedValue(requestedType)
    {
        var _loc5;
        var _loc2 = this.getFieldAccessor().getValue();
        var _loc3 = null;
        if (_loc2 != null)
        {
            if (_loc2 instanceof Array)
            {
                _loc3 = "Array";
            }
            else if (_loc2 instanceof XMLNode || _loc2 instanceof XMLNode)
            {
                _loc3 = "XML";
            }
            else
            {
                var _loc4 = typeof(_loc2);
                _loc3 = _loc4.charAt(0).toUpperCase() + _loc4.slice(1);
            } // end else if
        }
        else
        {
            _loc2 = null;
        } // end else if
        _loc5 = new mx.data.binding.TypedValue(_loc2, _loc3, null);
        return (_loc5);
    } // End of the function
    function getGettableTypes()
    {
        return (null);
    } // End of the function
    function setTypedValue(newValue)
    {
        this.getFieldAccessor().setValue(newValue.value, newValue);
        return (null);
    } // End of the function
    function getSettableTypes()
    {
        return (null);
    } // End of the function
    function getFieldAccessor()
    {
        return (component.createFieldAccessor(property, location, false));
    } // End of the function
} // End of Class
