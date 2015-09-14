package area
{
    import utility.*;

    public class AreaData extends Object
    {
        private var _id:int;
        private var _name:String;
        private var _englishName:String;
        private var _explanation:String;
        private var _areaDetailFile:String;
        private var _areaMapFile:String;

        public function AreaData()
        {
            return;
        }// end function

        public function get id() : int
        {
            return this._id;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        public function get englishName() : String
        {
            return this._englishName;
        }// end function

        public function get explanation() : String
        {
            return this._explanation;
        }// end function

        public function get areaDetailFile() : String
        {
            return this._areaDetailFile;
        }// end function

        public function get areaMapFile() : String
        {
            return this._areaMapFile;
        }// end function

        public function setXml(param1:XML) : void
        {
            this._id = param1.id;
            this._name = param1.name;
            this._englishName = param1.englishName;
            this._areaDetailFile = param1.areaDetailFile;
            this._areaMapFile = param1.areaMapFile;
            this._explanation = StringTools.xmlLineToStringLine(param1.explanation);
            return;
        }// end function

    }
}
