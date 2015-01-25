(function() {
  var ComplexConditions;

  module.exports = ComplexConditions = (function() {
    function ComplexConditions() {}

    ComplexConditions.prototype.rule = {
      name: 'complex_conditions',
      description: 'This rule prohibits complex conditions.\nComplex conditions are with && or ||.\nDefaults to unless conditions as they can be harder to read.',
      level: 'warn',
      message: 'Don\'t use complex conditions',
      conditions: {
        "if": false,
        unless: true,
        post_if: false,
        post_unless: true
      }
    };

    ComplexConditions.prototype.tokens = ['IF', 'POST_IF'];

    ComplexConditions.prototype.lintToken = function(token, tokenApi) {
      var nextToken, tokenIterator;
      tokenIterator = this.getTokenIterator(tokenApi);
      if (tokenApi.config[this.rule.name].conditions["if"] && this.isIf(token)) {
        while ((nextToken = tokenIterator()) && !this.isIndent(nextToken)) {
          if (this.isLogic(nextToken)) {
            return {
              context: "Complex condition with " + nextToken[1] + " in if"
            };
          }
        }
      } else if (tokenApi.config[this.rule.name].conditions.unless && this.isUnless(token)) {
        while ((nextToken = tokenIterator()) && !this.isIndent(nextToken)) {
          if (this.isLogic(nextToken)) {
            return {
              context: "Complex condition with " + nextToken[1] + " in unless"
            };
          }
        }
      } else if (tokenApi.config[this.rule.name].conditions.post_if && this.isPostIf(token)) {
        while ((nextToken = tokenIterator()) && !this.isTerminator(nextToken)) {
          if (this.isLogic(nextToken)) {
            return {
              context: "Complex condition with " + nextToken[1] + " in post if"
            };
          }
        }
      } else if (tokenApi.config[this.rule.name].conditions.post_unless && this.isPostUnless(token)) {
        while ((nextToken = tokenIterator()) && !this.isTerminator(nextToken)) {
          if (this.isLogic(nextToken)) {
            return {
              context: "Complex condition with " + nextToken[1] + " in post unless"
            };
          }
        }
      }
    };

    ComplexConditions.prototype.getTokenIterator = function(tokenApi) {
      var i;
      i = 1;
      return function() {
        return tokenApi.peek(i++);
      };
    };

    ComplexConditions.prototype.isIndent = function(token) {
      return token[0] === 'INDENT';
    };

    ComplexConditions.prototype.isTerminator = function(token) {
      return token[0] === 'TERMINATOR';
    };

    ComplexConditions.prototype.isIf = function(token) {
      return token[0] === 'IF' && token[1] === 'if';
    };

    ComplexConditions.prototype.isUnless = function(token) {
      return token[0] === 'IF' && token[1] === 'unless';
    };

    ComplexConditions.prototype.isPostIf = function(token) {
      return token[0] === 'POST_IF' && token[1] === 'if';
    };

    ComplexConditions.prototype.isPostUnless = function(token) {
      return token[0] === 'POST_IF' && token[1] === 'unless';
    };

    ComplexConditions.prototype.isLogic = function(token) {
      return token[0] === 'LOGIC';
    };

    return ComplexConditions;

  })();

}).call(this);
