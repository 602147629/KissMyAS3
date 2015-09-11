class mx.data.binding.DateBase extends mx.data.binding.DataAccessor
{
    var dataAccessor;
    function DateBase()
    {
        super();
    } // End of the function
    function internalToExternal(rawValue)
    {
        return (null);
    } // End of the function
    function externalToInternal(value)
    {
        return (null);
    } // End of the function
    function externalTypeName()
    {
        return (null);
    } // End of the function
    function internalTypeName()
    {
        return (null);
    } // End of the function
    function getTypedValue(requestedType)
    {
        var _loc3;
        if (requestedType == this.externalTypeName() || requestedType == null)
        {
            var _loc4 = dataAccessor.getTypedValue();
            var _loc2 = this.internalToExternal(_loc4.value);
            _loc3 = new mx.data.binding.TypedValue(_loc2, this.externalTypeName());
        } // end if
        return (_loc3);
    } // End of the function
    function getGettableTypes()
    {
        return ([this.externalTypeName()]);
    } // End of the function
    function setTypedValue(newValue)
    {
        if (newValue.typeName == this.externalTypeName() || newValue.typeName == null)
        {
            var _loc4 = this.externalToInternal(newValue.value);
            var _loc3;
            if (!_loc4)
            {
                _loc3 = [mx.data.binding.DataAccessor.conversionFailed(newValue, this.internalTypeName())];
            } // end if
            var _loc5 = dataAccessor.setTypedValue(new mx.data.binding.TypedValue(_loc4, this.internalTypeName()));
            if (_loc3)
            {
                return (_loc3);
            }
            else
            {
                return (_loc5);
            } // end else if
        }
        else
        {
            return ([mx.data.binding.DataAccessor.conversionFailed(newValue, this.internalTypeName())]);
        } // end else if
    } // End of the function
    function getSettableTypes()
    {
        return ([this.externalTypeName()]);
    } // End of the function
    static function extractTokenDate(value, tokenInfo)
    {
        var _loc1 = "";
        if (value != null)
        {
            switch (tokenInfo.token)
            {
                case "M":
                {
                    var _loc5 = value.getMonth() + 1;
                    if (_loc5 < 10)
                    {
                        _loc1 = _loc1 + "0";
                    } // end if
                    _loc1 = _loc1 + _loc5.toString();
                    break;
                } 
                case "Y":
                {
                    var _loc6 = value.getFullYear().toString();
                    if (tokenInfo.end - tokenInfo.begin < 3)
                    {
                        _loc1 = _loc6.substr(2);
                    }
                    else
                    {
                        _loc1 = _loc6;
                    } // end else if
                    break;
                } 
                case "D":
                {
                    var _loc3 = value.getDate();
                    if (_loc3 < 10)
                    {
                        _loc1 = _loc1 + "0";
                    } // end if
                    _loc1 = _loc1 + _loc3.toString();
                    break;
                } 
                case "H":
                {
                    var _loc8 = value.getHours();
                    if (_loc8 < 10)
                    {
                        _loc1 = _loc1 + "0";
                    } // end if
                    _loc1 = _loc1 + _loc8.toString();
                    break;
                } 
                case "N":
                {
                    var _loc7 = value.getMinutes();
                    if (_loc7 < 10)
                    {
                        _loc1 = _loc1 + "0";
                    } // end if
                    _loc1 = _loc1 + _loc7.toString();
                    break;
                } 
                case "S":
                {
                    var _loc4 = value.getSeconds();
                    if (_loc4 < 10)
                    {
                        _loc1 = _loc1 + "0";
                    } // end if
                    _loc1 = _loc1 + _loc4.toString();
                    break;
                } 
            } // End of switch
        } // end if
        return (_loc1);
    } // End of the function
    static function infuseTokenDate(tkData, tk, value)
    {
        if (tkData.length > 0)
        {
            switch (tk.token)
            {
                case "M":
                {
                    value.setMonth(Number(tkData) - 1);
                    break;
                } 
                case "D":
                {
                    value.setDate(Number(tkData));
                    break;
                } 
                case "Y":
                {
                    value.setYear(Number(tkData));
                    break;
                } 
                case "H":
                {
                    value.setHours(Number(tkData));
                    break;
                } 
                case "N":
                {
                    value.setMinutes(Number(tkData));
                    break;
                } 
                case "S":
                {
                    value.setSeconds(Number(tkData));
                    break;
                } 
            } // End of switch
        } // end if
    } // End of the function
} // End of Class
