/* Jison generated parser */
var jsonparse = (function(){
var parser = {trace: function trace() { },
yy: {},
symbols_: {"error":2,"Value":3,"STRING":4,"NUMBER":5,"Object":6,"Array":7,"Element":8,"%":9,"ElementList":10,"[":11,"]":12,"TERMINATOR":13,"AssignList":14,",":15,"AssignObj":16,"{":17,"}":18,"INDENT":19,"OUTDENT":20,":":21,"RootPlex":22,"Root":23,"$accept":0,"$end":1},
terminals_: {2:"error",4:"STRING",5:"NUMBER",9:"%",11:"[",12:"]",13:"TERMINATOR",15:",",17:"{",18:"}",19:"INDENT",20:"OUTDENT",21:":"},
productions_: [0,[3,1],[3,1],[3,1],[3,1],[8,2],[10,1],[10,2],[7,2],[7,3],[7,1],[7,2],[14,3],[14,3],[14,1],[6,2],[6,3],[6,1],[6,2],[6,3],[16,3],[22,1],[22,2],[23,1]],
performAction: function anonymous(yytext,yyleng,yylineno,yy,yystate,$$,_$) {

var $0 = $$.length - 1;
switch (yystate) {
case 1:this.$ = (function () {
        console.log('STRING -> Value', $$[$0]);
        return $$[$0];
      }());
break;
case 2:this.$ = (function () {
        console.log('NUMBER -> Value', $$[$0]);
        return Number($$[$0]);
      }());
break;
case 3:this.$ = (function () {
        console.log('Object -> Value', $$[$0]);
        return $$[$0];
      }());
break;
case 4:this.$ = (function () {
        console.log('Array -> Value', $$[$0]);
        return $$[$0];
      }());
break;
case 5:this.$ = (function () {
        console.log('Value ; -> Element', $$[$0-1]);
        return $$[$0-1];
      }());
break;
case 6:this.$ = (function () {
        console.log('Value', $$[$0]);
        return [$$[$0]];
      }());
break;
case 7:this.$ = (function () {
        console.log('ElementList Element -> ElementList', $$[$0-1], $$[$0]);
        $$[$0-1].push($$[$0]);
        return $$[$0-1];
      }());
break;
case 8:this.$ = [];
break;
case 9:this.$ = $$[$0-1];
break;
case 10:this.$ = (function () {
        console.log('ElementList -> Array', $$[$0]);
        return $$[$0];
      }());
break;
case 11:this.$ = (function () {
        console.log('ElementList TERMINATOR -> Array', $$[$0-1]);
        return $$[$0-1];
      }());
break;
case 12:this.$ = (function () {
        console.log('assignlist , assignobj matched', $$[$0-2], $$[$0]);
        $$[$0-2][$$[$0].key] = $$[$0].val;
        return $$[$0-2];
      }());
break;
case 13:this.$ = (function () {
        console.log('AssignList TERM AssignObj->AssignList', $$[$0-2], $$[$0]);
        $$[$0-2][$$[$0].key] = $$[$0].val;
        return $$[$0-2];
      }());
break;
case 14:this.$ = (function () {
        var b;
        console.log('AssignObj->AssignList', $$[$0]);
        b = {};
        b[$$[$0].key] = $$[$0].val;
        return b;
      }());
break;
case 15:this.$ = {};
break;
case 16:this.$ = $$[$0-1];
break;
case 17:this.$ = (function () {
        console.log('AssignList -> Object', $$[$0]);
        return $$[$0];
      }());
break;
case 18:this.$ = (function () {
        console.log('AssignList TERM -> Object', $$[$0-1]);
        return $$[$0-1];
      }());
break;
case 19:this.$ = (function () {
        console.log('Object matched', $$[$0-1]);
        return $$[$0-1];
      }());
break;
case 20:this.$ = (function () {
        console.log('STRING : Value -> AssignObj', $$[$0-2], $$[$0]);
        return {
          key: $$[$0-2],
          val: $$[$0]
        };
      }());
break;
case 21:this.$ = (function () {
        console.log("Value -> RootPlex", $$[$0]);
        return $$[$0];
      }());
break;
case 22:this.$ = (function () {
        console.log("Value TERM -> RootPlex", $$[$0-1]);
        return $$[$0-1];
      }());
break;
case 23:console.log('RootPlex->Root', $$[$0]); return $$[$0]
break;
}
},
table: [{3:3,4:[1,4],5:[1,5],6:6,7:7,8:14,10:12,11:[1,11],14:9,16:13,17:[1,8],19:[1,10],22:2,23:1},{1:[3]},{1:[2,23]},{1:[2,21],9:[1,16],13:[1,15]},{1:[2,1],9:[2,1],13:[2,1],15:[2,1],18:[2,1],20:[2,1],21:[1,17]},{1:[2,2],9:[2,2],13:[2,2],15:[2,2],18:[2,2],20:[2,2]},{1:[2,3],9:[2,3],13:[2,3],15:[2,3],18:[2,3],20:[2,3]},{1:[2,4],9:[2,4],13:[2,4],15:[2,4],18:[2,4],20:[2,4]},{4:[1,20],14:19,16:13,18:[1,18]},{1:[2,17],9:[2,17],13:[1,21],15:[1,22],18:[2,17],20:[2,17]},{4:[1,20],14:23,16:13},{3:26,4:[1,4],5:[1,5],6:6,7:7,8:14,10:25,11:[1,11],12:[1,24],14:9,16:13,17:[1,8],19:[1,10]},{1:[2,10],3:26,4:[1,4],5:[1,5],6:6,7:7,8:28,9:[2,10],10:12,11:[1,11],13:[1,27],14:9,15:[2,10],16:13,17:[1,8],18:[2,10],19:[1,10],20:[2,10]},{1:[2,14],9:[2,14],13:[2,14],15:[2,14],18:[2,14],20:[2,14]},{1:[2,6],4:[2,6],5:[2,6],9:[2,6],11:[2,6],12:[2,6],13:[2,6],15:[2,6],17:[2,6],18:[2,6],19:[2,6],20:[2,6]},{1:[2,22]},{1:[2,5],4:[2,5],5:[2,5],9:[2,5],11:[2,5],12:[2,5],13:[2,5],15:[2,5],17:[2,5],18:[2,5],19:[2,5],20:[2,5]},{3:29,4:[1,4],5:[1,5],6:6,7:7,8:14,10:12,11:[1,11],14:9,16:13,17:[1,8],19:[1,10]},{1:[2,15],9:[2,15],13:[2,15],15:[2,15],18:[2,15],20:[2,15]},{13:[1,31],15:[1,22],18:[1,30]},{21:[1,17]},{1:[2,18],4:[1,20],9:[2,18],13:[2,18],15:[2,18],16:32,18:[2,18],20:[2,18]},{4:[1,20],16:33},{13:[1,31],15:[1,22],20:[1,34]},{1:[2,8],9:[2,8],13:[2,8],15:[2,8],18:[2,8],20:[2,8]},{1:[2,10],3:26,4:[1,4],5:[1,5],6:6,7:7,8:28,9:[2,10],10:12,11:[1,11],12:[1,35],13:[1,27],14:9,15:[2,10],16:13,17:[1,8],18:[2,10],19:[1,10],20:[2,10]},{9:[1,16]},{1:[2,11],9:[2,11],13:[2,11],15:[2,11],18:[2,11],20:[2,11]},{1:[2,7],4:[2,7],5:[2,7],9:[2,7],11:[2,7],12:[2,7],13:[2,7],15:[2,7],17:[2,7],18:[2,7],19:[2,7],20:[2,7]},{1:[2,20],9:[1,16],13:[2,20],15:[2,20],18:[2,20],20:[2,20]},{1:[2,16],9:[2,16],13:[2,16],15:[2,16],18:[2,16],20:[2,16]},{4:[1,20],16:32},{1:[2,13],9:[2,13],13:[2,13],15:[2,13],18:[2,13],20:[2,13]},{1:[2,12],9:[2,12],13:[2,12],15:[2,12],18:[2,12],20:[2,12]},{1:[2,19],9:[2,19],13:[2,19],15:[2,19],18:[2,19],20:[2,19]},{1:[2,9],9:[2,9],13:[2,9],15:[2,9],18:[2,9],20:[2,9]}],
defaultActions: {2:[2,23],15:[2,22]},
parseError: function parseError(str, hash) {
    throw new Error(str);
},
parse: function parse(input) {
    var self = this, stack = [0], vstack = [null], lstack = [], table = this.table, yytext = "", yylineno = 0, yyleng = 0, recovering = 0, TERROR = 2, EOF = 1;
    this.lexer.setInput(input);
    this.lexer.yy = this.yy;
    this.yy.lexer = this.lexer;
    this.yy.parser = this;
    if (typeof this.lexer.yylloc == "undefined")
        this.lexer.yylloc = {};
    var yyloc = this.lexer.yylloc;
    lstack.push(yyloc);
    var ranges = this.lexer.options && this.lexer.options.ranges;
    if (typeof this.yy.parseError === "function")
        this.parseError = this.yy.parseError;
    function popStack(n) {
        stack.length = stack.length - 2 * n;
        vstack.length = vstack.length - n;
        lstack.length = lstack.length - n;
    }
    function lex() {
        var token;
        token = self.lexer.lex() || 1;
        if (typeof token !== "number") {
            token = self.symbols_[token] || token;
        }
        return token;
    }
    var symbol, preErrorSymbol, state, action, a, r, yyval = {}, p, len, newState, expected;
    while (true) {
        state = stack[stack.length - 1];
        if (this.defaultActions[state]) {
            action = this.defaultActions[state];
        } else {
            if (symbol === null || typeof symbol == "undefined") {
                symbol = lex();
            }
            action = table[state] && table[state][symbol];
        }
        if (typeof action === "undefined" || !action.length || !action[0]) {
            var errStr = "";
            if (!recovering) {
                expected = [];
                for (p in table[state])
                    if (this.terminals_[p] && p > 2) {
                        expected.push("'" + this.terminals_[p] + "'");
                    }
                if (this.lexer.showPosition) {
                    errStr = "Parse error on line " + (yylineno + 1) + ":\n" + this.lexer.showPosition() + "\nExpecting " + expected.join(", ") + ", got '" + (this.terminals_[symbol] || symbol) + "'";
                } else {
                    errStr = "Parse error on line " + (yylineno + 1) + ": Unexpected " + (symbol == 1?"end of input":"'" + (this.terminals_[symbol] || symbol) + "'");
                }
                this.parseError(errStr, {text: this.lexer.match, token: this.terminals_[symbol] || symbol, line: this.lexer.yylineno, loc: yyloc, expected: expected});
            }
        }
        if (action[0] instanceof Array && action.length > 1) {
            throw new Error("Parse Error: multiple actions possible at state: " + state + ", token: " + symbol);
        }
        switch (action[0]) {
        case 1:
            stack.push(symbol);
            vstack.push(this.lexer.yytext);
            lstack.push(this.lexer.yylloc);
            stack.push(action[1]);
            symbol = null;
            if (!preErrorSymbol) {
                yyleng = this.lexer.yyleng;
                yytext = this.lexer.yytext;
                yylineno = this.lexer.yylineno;
                yyloc = this.lexer.yylloc;
                if (recovering > 0)
                    recovering--;
            } else {
                symbol = preErrorSymbol;
                preErrorSymbol = null;
            }
            break;
        case 2:
            len = this.productions_[action[1]][1];
            yyval.$ = vstack[vstack.length - len];
            yyval._$ = {first_line: lstack[lstack.length - (len || 1)].first_line, last_line: lstack[lstack.length - 1].last_line, first_column: lstack[lstack.length - (len || 1)].first_column, last_column: lstack[lstack.length - 1].last_column};
            if (ranges) {
                yyval._$.range = [lstack[lstack.length - (len || 1)].range[0], lstack[lstack.length - 1].range[1]];
            }
            r = this.performAction.call(yyval, yytext, yyleng, yylineno, this.yy, action[1], vstack, lstack);
            if (typeof r !== "undefined") {
                return r;
            }
            if (len) {
                stack = stack.slice(0, -1 * len * 2);
                vstack = vstack.slice(0, -1 * len);
                lstack = lstack.slice(0, -1 * len);
            }
            stack.push(this.productions_[action[1]][0]);
            vstack.push(yyval.$);
            lstack.push(yyval._$);
            newState = table[stack[stack.length - 2]][stack[stack.length - 1]];
            stack.push(newState);
            break;
        case 3:
            return true;
        }
    }
    return true;
}
};

function Parser () { this.yy = {}; }Parser.prototype = parser;parser.Parser = Parser;
return new Parser;
})();
if (typeof require !== 'undefined' && typeof exports !== 'undefined') {
exports.parser = jsonparse;
exports.Parser = jsonparse.Parser;
exports.parse = function () { return jsonparse.parse.apply(jsonparse, arguments); }
exports.main = function commonjsMain(args) {
    if (!args[1])
        throw new Error('Usage: '+args[0]+' FILE');
    var source, cwd;
    if (typeof process !== 'undefined') {
        source = require('fs').readFileSync(require('path').resolve(args[1]), "utf8");
    } else {
        source = require("file").path(require("file").cwd()).join(args[1]).read({charset: "utf-8"});
    }
    return exports.parser.parse(source);
}
if (typeof module !== 'undefined' && require.main === module) {
  exports.main(typeof process !== 'undefined' ? process.argv.slice(1) : require("system").args);
}
}