package gs
{
    import flash.net.*;

    public class Cookie extends Object
    {
        private var _time:uint;
        private var _name:String;
        private var _so:SharedObject;

        public function Cookie(param1:String = "klstudio", param2:uint = 3600)
        {
            this._name = param1;
            this._time = param2;
            this._so = SharedObject.getLocal(param1, "/");
            return;
        }// end function

        public function clearTimeOut() : void
        {
            var key:*;
            var obj:* = this._so.data.cookie;
            if (obj == undefined)
            {
                return;
            }
            var _loc_2:* = 0;
            var _loc_3:* = obj;
            while (_loc_3 in _loc_2)
            {
                
                key = _loc_3[_loc_2];
                if (obj[key] == undefined || obj[key].time == undefined || this.isTimeOut(obj[key].time))
                {
                    delete obj[key];
                }
            }
            this._so.data.cookie = obj;
            try
            {
                this._so.flush();
            }
            catch (e)
            {
            }
            return;
        }// end function

        private function isTimeOut(param1:uint) : Boolean
        {
            var _loc_2:* = new Date();
            return param1 + this._time * 1000 < _loc_2.getTime();
        }// end function

        public function getTimeOut() : uint
        {
            return this._time;
        }// end function

        public function getName() : String
        {
            return this._name;
        }// end function

        public function clear() : void
        {
            this._so.clear();
            return;
        }// end function

        public function put(param1:String, param2) : void
        {
            var obj:Object;
            var key:* = param1;
            var value:* = param2;
            var today:* = new Date();
            key = "key_" + key;
            value.time = today.getTime();
            if (this._so.data.cookie == undefined)
            {
                obj;
                obj[key] = value;
                this._so.data.cookie = obj;
            }
            else
            {
                this._so.data.cookie[key] = value;
            }
            try
            {
                this._so.flush();
            }
            catch (e)
            {
            }
            return;
        }// end function

        public function remove(param1:String) : void
        {
            var key:* = param1;
            if (this.contains(key))
            {
                delete this._so.data.cookie["key_" + key];
                try
                {
                    this._so.flush();
                }
                catch (e)
                {
                }
            }
            return;
        }// end function

        public function get(param1:String) : Object
        {
            return this.contains(param1) ? (this._so.data.cookie["key_" + param1]) : (null);
        }// end function

        public function contains(param1:String) : Boolean
        {
            param1 = "key_" + param1;
            return this._so.data.cookie != undefined && this._so.data.cookie[param1] != undefined;
        }// end function

    }
}
