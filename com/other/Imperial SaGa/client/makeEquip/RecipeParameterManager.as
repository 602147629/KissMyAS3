package makeEquip
{
    import resource.*;

    public class RecipeParameterManager extends Object
    {
        private var _loader:XmlLoader;
        private var _bCreated:Boolean;
        private var _aRecipe:Array;
        private static var _instance:RecipeParameterManager = null;

        public function RecipeParameterManager()
        {
            this._aRecipe = [];
            return;
        }// end function

        public function get bCreated() : Boolean
        {
            return this._bCreated;
        }// end function

        public function loadData() : void
        {
            this._loader = new XmlLoader();
            this._loader.load(ResourcePath.PARAMETER_PATH + "RecipeParameter.xml", this.cbLoadComplete, false);
            return;
        }// end function

        public function isLoaded() : Boolean
        {
            if (this._loader != null)
            {
                return this._loader.bLoaded;
            }
            return false;
        }// end function

        private function cbLoadComplete(param1:XML) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            for each (_loc_2 in param1.Data)
            {
                
                _loc_3 = new RecipeParameter();
                _loc_3.setXml(_loc_2);
                this._aRecipe.push(_loc_3);
            }
            this._loader.release();
            this._loader = null;
            this._bCreated = true;
            return;
        }// end function

        public function getRecipeParam(param1:int) : RecipeParameter
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aRecipe)
            {
                
                if (_loc_2.id == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public static function getInstance() : RecipeParameterManager
        {
            if (_instance == null)
            {
                _instance = new RecipeParameterManager;
            }
            return _instance;
        }// end function

    }
}
