class mx.data.components.datasetclasses.DeltaItem extends Object
{
    var __name, __kind, __owner, __oldValue, __newValue, __curValue, __argList, __message, __get__argList, __get__curValue, __get__delta, __get__kind, __get__message, __get__name, __get__newValue, __get__oldValue;
    function DeltaItem(kind, name, init, owner)
    {
        super();
        __name = name;
        __kind = kind;
        __owner = owner;
        if (kind == mx.data.components.datasetclasses.DeltaItem.Property)
        {
            __oldValue = init.oldValue;
            __newValue = init.newValue;
            __curValue = init.curValue;
        }
        else
        {
            __argList = init.argList;
        } // end else if
        __message = init.message == undefined ? ("") : (init.message);
        __owner.addDeltaItem(this);
    } // End of the function
    function get argList()
    {
        return (__kind == mx.data.components.datasetclasses.DeltaItem.Method ? (__argList) : (null));
    } // End of the function
    function get delta()
    {
        return (__owner);
    } // End of the function
    function get kind()
    {
        return (__kind);
    } // End of the function
    function get message()
    {
        return (__message);
    } // End of the function
    function get name()
    {
        return (__name);
    } // End of the function
    function get curValue()
    {
        return (__curValue);
    } // End of the function
    function get newValue()
    {
        return (__kind == mx.data.components.datasetclasses.DeltaItem.Property ? (__newValue) : (null));
    } // End of the function
    function get oldValue()
    {
        return (__kind == mx.data.components.datasetclasses.DeltaItem.Property ? (__oldValue) : (null));
    } // End of the function
    static var Property = 0;
    static var Method = 1;
} // End of Class
