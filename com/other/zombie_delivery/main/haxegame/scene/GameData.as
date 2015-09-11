package haxegame.scene
{
    import com.dango_itimi.as3_and_createjs.*;
    import com.dango_itimi.as3_and_createjs.display.*;
    import com.dango_itimi.as3_and_createjs.event.*;
    import com.dango_itimi.as3_and_createjs.layout.*;
    import com.dango_itimi.utils.*;
    import flash.*;
    import flash.display.*;
    import haxegame.save.*;
    import haxegame.text.*;

    public class GameData extends Object
    {
        public var zombieScoreLine:ScoreLine;
        public var view:GameDataView;
        public var record:Record;
        public var maxComboScoreLine:ScoreLine;
        public var layer:IDisplayObjectContainer;
        public var humanScoreLine:ScoreLine;
        public var highScoreLine:ScoreLine;
        public var backButton:MouseEventChecker;

        public function GameData(param1:IDisplayObjectContainer = undefined) : void
        {
            var _loc_2:* = null as Record;
            if (Boot.skip_constructor)
            {
                return;
            }
            layer = param1;
            if (Record.instance == null)
            {
                _loc_2 = new Record();
                Record.instance = _loc_2;
                record = _loc_2;
            }
            else
            {
                record = Record.instance;
            }
            view = new GameDataView();
            highScoreLine = setScore(view.highScorePosition);
            maxComboScoreLine = setScore(view.maxComboScorePosition);
            zombieScoreLine = setScore(view.zombieScorePosition);
            humanScoreLine = setScore(view.humanScorePosition);
            backButton = CommonClassSet.createMouseEventChecker(view.backButton);
            return;
        }// end function

        public function show() : void
        {
            var _loc_6:* = null as MovieClip;
            layer.addChild(view);
            var _loc_1:* = highScoreLine;
            var _loc_2:* = StringUtil.addZeroToHeadOfNumber(record.saveData.highScore, _loc_1.place);
            _loc_1.numericLine.createFromString(_loc_2);
            var _loc_3:* = _loc_1.numericLine;
            var _loc_4:* = 0;
            var _loc_5:* = _loc_3.graphicsSet;
            while (_loc_4 < _loc_5.length)
            {
                
                _loc_6 = _loc_5[_loc_4];
                _loc_4++;
                _loc_3.layer.addChild(_loc_6);
            }
            _loc_1 = maxComboScoreLine;
            _loc_2 = StringUtil.addZeroToHeadOfNumber(record.saveData.maxCombo, _loc_1.place);
            _loc_1.numericLine.createFromString(_loc_2);
            _loc_3 = _loc_1.numericLine;
            _loc_4 = 0;
            _loc_5 = _loc_3.graphicsSet;
            while (_loc_4 < _loc_5.length)
            {
                
                _loc_6 = _loc_5[_loc_4];
                _loc_4++;
                _loc_3.layer.addChild(_loc_6);
            }
            _loc_1 = zombieScoreLine;
            _loc_2 = StringUtil.addZeroToHeadOfNumber(record.saveData.zombie, _loc_1.place);
            _loc_1.numericLine.createFromString(_loc_2);
            _loc_3 = _loc_1.numericLine;
            _loc_4 = 0;
            _loc_5 = _loc_3.graphicsSet;
            while (_loc_4 < _loc_5.length)
            {
                
                _loc_6 = _loc_5[_loc_4];
                _loc_4++;
                _loc_3.layer.addChild(_loc_6);
            }
            _loc_1 = humanScoreLine;
            _loc_2 = StringUtil.addZeroToHeadOfNumber(record.saveData.human, _loc_1.place);
            _loc_1.numericLine.createFromString(_loc_2);
            _loc_3 = _loc_1.numericLine;
            _loc_4 = 0;
            _loc_5 = _loc_3.graphicsSet;
            while (_loc_4 < _loc_5.length)
            {
                
                _loc_6 = _loc_5[_loc_4];
                _loc_4++;
                _loc_3.layer.addChild(_loc_6);
            }
            setAchievement(view.comboAchievement, record.saveData.comboAchievement);
            setAchievement(view.scoreAchievement, record.saveData.scoreAchievement);
            setAchievement(view.zombieAchievement, record.saveData.zombieAchievement);
            setAchievement(view.humanAchievement, record.saveData.humanAchievement);
            setAchievement(view.playCountAchievement, record.saveData.playCountAchievement);
            setAchievement(view.comboSecretAchievement, record.saveData.comboSecretAchievement);
            setAchievement(view.scoreSecretAchievement, record.saveData.scoreSecretAchievement);
            setAchievement(view.zombieSecretAchievement, record.saveData.zombieSecretAchievement);
            setAchievement(view.humanSecretAchievement, record.saveData.humanSecretAchievement);
            setAchievement(view.playCountSecretAchievement, record.saveData.playCountSecretAchievement);
            return;
        }// end function

        public function setScore(param1:DisplayObject) : ScoreLine
        {
            param1.visible = false;
            return new ScoreLine(layer, param1.x, param1.y, 7);
        }// end function

        public function setAchievement(param1:DisplayObject, param2:Boolean) : void
        {
            param1.visible = param2;
            return;
        }// end function

        public function hide() : void
        {
            var _loc_4:* = null as MovieClip;
            var _loc_1:* = highScoreLine.numericLine;
            var _loc_2:* = 0;
            var _loc_3:* = _loc_1.graphicsSet;
            while (_loc_2 < _loc_3.length)
            {
                
                _loc_4 = _loc_3[_loc_2];
                _loc_2++;
                _loc_1.layer.removeChild(_loc_4);
            }
            _loc_1 = maxComboScoreLine.numericLine;
            _loc_2 = 0;
            _loc_3 = _loc_1.graphicsSet;
            while (_loc_2 < _loc_3.length)
            {
                
                _loc_4 = _loc_3[_loc_2];
                _loc_2++;
                _loc_1.layer.removeChild(_loc_4);
            }
            _loc_1 = zombieScoreLine.numericLine;
            _loc_2 = 0;
            _loc_3 = _loc_1.graphicsSet;
            while (_loc_2 < _loc_3.length)
            {
                
                _loc_4 = _loc_3[_loc_2];
                _loc_2++;
                _loc_1.layer.removeChild(_loc_4);
            }
            _loc_1 = humanScoreLine.numericLine;
            _loc_2 = 0;
            _loc_3 = _loc_1.graphicsSet;
            while (_loc_2 < _loc_3.length)
            {
                
                _loc_4 = _loc_3[_loc_2];
                _loc_2++;
                _loc_1.layer.removeChild(_loc_4);
            }
            layer.removeChild(view);
            return;
        }// end function

    }
}
