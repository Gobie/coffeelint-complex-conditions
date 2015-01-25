coffeelint = require 'coffeelint'
expect = require('chai').expect

ComplexConditions = require '../src/complex_conditions'

coffeelint.registerRule ComplexConditions

config =
  complex_conditions:
    level: 'error'
    conditions:
      if: yes
      unless: yes
      post_if: yes
      post_unless: yes

describe 'ComplexConditions', ->
  describe 'if condition', ->
    it 'should warn when used with logic', ->
      result = coffeelint.lint '''
        if 1 or 2
          3
        ''', config
      expect(result).to.be.ok
      expect(result[0].context).to.equal 'Complex condition with || in if'

    it 'should warn when used with logic in multiline conditon', ->
      result = coffeelint.lint '''
        if 1 and
        2
          3
        ''', config
      expect(result).to.be.ok
      expect(result[0].context).to.equal 'Complex condition with && in if'

  describe 'unless condition', ->
    it 'should warn when used with logic', ->
      result = coffeelint.lint '''
        unless 1 or 2
          3
        ''', config
      expect(result).to.be.ok
      expect(result[0].context).to.equal 'Complex condition with || in unless'

    it 'should warn when used with logic in multiline conditon', ->
      result = coffeelint.lint '''
        unless 1 and
        2
          3
        ''', config
      expect(result).to.be.ok
      expect(result[0].context).to.equal 'Complex condition with && in unless'

  describe 'post if condition', ->
    it 'should warn when used with logic', ->
      result = coffeelint.lint '''
        1 if 2 and 3
        ''', config
      expect(result).to.be.ok
      expect(result[0].context).to.equal 'Complex condition with && in post if'

    it 'should warn when used with logic in multiline conditon', ->
      result = coffeelint.lint '''
        1 if 2 and
        3
        ''', config
      expect(result).to.be.ok
      expect(result[0].context).to.equal 'Complex condition with && in post if'

  describe 'post unless condition', ->
    it 'should warn when used with logic', ->
      result = coffeelint.lint '''
        1 unless 2 and 3
        ''', config
      expect(result).to.be.ok
      expect(result[0].context).to.equal 'Complex condition with && in post unless'

    it 'should warn when used with logic in multiline conditon', ->
      result = coffeelint.lint '''
        1 unless 2 and
        3
        ''', config
      expect(result).to.be.ok
      expect(result[0].context).to.equal 'Complex condition with && in post unless'

  describe 'strings', ->
    it 'should ignore conditions in strings', ->
      result = coffeelint.lint '''
        '1 unless 2 and 3'
        '1 if 2 and 3'
        ''', config
      expect(result).to.be.empty

  describe 'comments', ->
    it 'should ignore conditions in comments', ->
      result = coffeelint.lint '''
        # 1 unless 2 and 3
        ### 1 if 2 and 3 ###
        ''', config
      expect(result).to.be.empty
