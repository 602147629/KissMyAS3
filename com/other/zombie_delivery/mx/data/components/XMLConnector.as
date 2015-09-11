class mx.data.components.XMLConnector extends mx.data.components.connclasses.RPCCall
{
    var direction, triggerSetup, params, notifyStatus, ignoreWhite, needData, xmlconnector, parseXML, status, URL, bumpCallsInProgress;
    function XMLConnector()
    {
        super();
    } // End of the function
    function trigger()
    {
        _global.__dataLogger.logData(this, "XMLConnector Triggered, <URL>", this);
        ++_global.__dataLogger.nestLevel;
        if (this.triggerSetup(direction != "receive"))
        {
            if (params != null)
            {
                if (direction == "receive")
                {
                    _global.__dataLogger.logData(this, "Warning: direction is \'receive\', but params are non-null: <params>", this, mx.data.binding.Log.WARNING);
                }
                else
                {
                    if (!(params instanceof XML))
                    {
                        this.notifyStatus("Fault", {faultcode: "XMLConnector.Not.XML", faultstring: "params is not an XML object"});
                        return;
                    } // end if
                    if (params.status != 0)
                    {
                        this.notifyStatus("Fault", {faultcode: "XMLConnector.Parse.Error", faultstring: "params had XML parsing error " + params.status});
                        return;
                    } // end if
                } // end else if
            }
            else if (direction != "receive")
            {
                this.notifyStatus("Fault", {faultcode: "XMLConnector.Params.Missing", faultstring: "Direction is \'send\' or \'send/receive\', but params are null"});
                return;
            } // end else if
            var _loc4 = params;
            if (_loc4 == null || direction == "receive")
            {
                _loc4 = new XML();
            } // end if
            var _loc3 = new XML();
            _loc3.ignoreWhite = ignoreWhite;
            _loc3.xmlconnector = this;
            _loc3.needData = direction != "send";
            _loc3.onData = function (data)
            {
                if (needData)
                {
                    if (data == undefined)
                    {
                        xmlconnector.notifyStatus("Fault", {faultcode: "XMLConnector.No.Data.Received", faultstring: "Was expecting data from the server, but none was received"});
                    }
                    else
                    {
                        this.parseXML(data);
                        if (status != 0)
                        {
                            xmlconnector.notifyStatus("Fault", {faultcode: "XMLConnector.Results.Parse.Error", faultstring: "received data had an XML parsing error " + status});
                        }
                        else
                        {
                            xmlconnector.setResult(this);
                        } // end if
                    } // end else if
                } // end else if
                xmlconnector.bumpCallsInProgress(-1);
            };
            _global.__dataLogger.logData(this, "Invoking XMLConnector <me.URL>(<params>)", {me: this, params: _loc4});
            _loc4.contentType = "text/xml";
            _loc4.sendAndLoad(URL, _loc3);
            this.bumpCallsInProgress(1);
        } // end if
        --_global.__dataLogger.nestLevel;
    } // End of the function
} // End of Class
