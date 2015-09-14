package ending
{
    import flash.display.*;
    import message.*;
    import quest.*;
    import resource.*;

    public class EndingChronologyDetail extends Object
    {
        private var _baseMc:MovieClip;

        public function EndingChronologyDetail(param1:DisplayObjectContainer)
        {
            this._baseMc = ResourceManager.getInstance().createMovieClip(ResourcePath.RESULT_PATH + "UI_Result.swf", "chronologicalSwindMc");
            param1.addChild(this._baseMc);
            return;
        }// end function

        public function get bOutOfBound() : Boolean
        {
            return this._baseMc.y < -251 || this._baseMc.y > 219;
        }// end function

        public function release() : void
        {
            if (this._baseMc.parent)
            {
                this._baseMc.parent.removeChild(this._baseMc);
            }
            return;
        }// end function

        public function setQuestData(param1:ChronologyData) : void
        {
            this._baseMc.visible = param1 != null;
            if (param1 == null)
            {
                return;
            }
            TextControl.setAgYearText(this._baseMc.questEra, this._baseMc.questYear, QuestManager.getYear(param1.chapter, param1.year));
            TextControl.setText(this._baseMc.questNameMc.textDt, param1.questTitle);
            var _loc_2:* = QuestManager.questRankLabel(param1.totalComplete);
            this._baseMc.resultRankMc.gotoAndStop(_loc_2);
            return;
        }// end function

        public function setPosition(param1:int, param2:int) : void
        {
            this._baseMc.x = param1;
            this._baseMc.y = param2;
            return;
        }// end function

    }
}
