class mx.xpath.FilterExpr
{
    var __get__attr, __get__name, __get__value, __set__attr, __set__name, __set__value;
    function FilterExpr(attrInit, nameInit, valueInit)
    {
        __attr = attrInit;
        __name = nameInit;
        __value = valueInit;
    } // End of the function
    function get attr()
    {
        return (__attr);
    } // End of the function
    function set attr(newVal)
    {
        __attr = newVal;
        //return (this.attr());
        null;
    } // End of the function
    function get name()
    {
        return (__name);
    } // End of the function
    function set name(newVal)
    {
        __name = newVal;
        //return (this.name());
        null;
    } // End of the function
    function get value()
    {
        return (__value);
    } // End of the function
    function set value(newVal)
    {
        __value = newVal;
        //return (this.value());
        null;
    } // End of the function
    var __attr = false;
    var __value = null;
    var __name = null;
} // End of Class
