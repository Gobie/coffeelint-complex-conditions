module.exports = class ComplexConditions
  rule:
    name: 'complex_conditions'
    description: '''
      This rule prohibits complex conditions.
      Complex conditions are with && or ||.
      Defaults to unless conditions as they can be harder to read.
      '''
    level: 'warn'
    message: 'Don\'t use complex conditions'
    conditions:
      if: no
      unless: yes
      post_if: no
      post_unless: yes

  tokens: ['IF', 'POST_IF']

  lintToken: (token, tokenApi) ->
    tokenIterator = @getTokenIterator tokenApi

    if tokenApi.config[@rule.name].conditions.if and @isIf token
      while (nextToken = tokenIterator()) and not @isIndent nextToken
        return context: "Complex condition with #{nextToken[1]} in if" if @isLogic nextToken

    else if tokenApi.config[@rule.name].conditions.unless and @isUnless token
      while (nextToken = tokenIterator()) and not @isIndent nextToken
        return context: "Complex condition with #{nextToken[1]} in unless" if @isLogic nextToken

    else if tokenApi.config[@rule.name].conditions.post_if and @isPostIf token
      while (nextToken = tokenIterator()) and not @isTerminator nextToken
        return context: "Complex condition with #{nextToken[1]} in post if" if @isLogic nextToken

    else if tokenApi.config[@rule.name].conditions.post_unless and @isPostUnless token
      while (nextToken = tokenIterator()) and not @isTerminator nextToken
        return context: "Complex condition with #{nextToken[1]} in post unless" if @isLogic nextToken

  getTokenIterator: (tokenApi) ->
    i = 1
    ->
      tokenApi.peek i++

  isIndent: (token) ->
    token[0] is 'INDENT'

  isTerminator: (token) ->
    token[0] is 'TERMINATOR'

  isIf: (token) ->
    token[0] is 'IF' and token[1] is 'if'

  isUnless: (token) ->
    token[0] is 'IF' and token[1] is 'unless'

  isPostIf: (token) ->
    token[0] is 'POST_IF' and token[1] is 'if'

  isPostUnless: (token) ->
    token[0] is 'POST_IF' and token[1] is 'unless'

  isLogic: (token) ->
    token[0] is 'LOGIC'
