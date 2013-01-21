{recurser} = require("../src/json2humon")
sinon = require 'sinon'
{sinonJasmine} = require './jasmine-sinon.js'
# jasmine.addMatchers sinonJasmine.getMatchers()


describe "Recurser", ->
  j2h = recurser.json2humon
  beforeEach ->
      @addMatchers sinonJasmine.getMatchers()

  describe "type checkers", ->
    hash1 = {a: 5}
    hash2 = {}
    hash3 = {a: {b: 5}}
    arr1 = [1, 2, 3]
    arr2 = []
    bool = false
    num = 3.14
    str = "111"

    describe "isHash", ->
      it "should respond true for an objective",  ->
        expect(recurser.isHash(hash1)).toBe true
        expect(recurser.isHash(hash2)).toBe true
        expect(recurser.isHash(hash3)).toBe true
      it "should respond false for arrays", ->
        expect(recurser.isHash(arr1)).toBe false
        expect(recurser.isHash(arr2)).toBe false
      it "should respond false for literals", ->
        expect(recurser.isHash(bool)).toBe false
        expect(recurser.isHash(num)).toBe false
        expect(recurser.isHash(str)).toBe false

    describe "isArray", ->
      it "should respond false for arrrays", ->
        expect(recurser.isArray(hash1)).toBe false
        expect(recurser.isArray(hash2)).toBe false
        expect(recurser.isArray(hash3)).toBe false
      it "should respond true for arrrays", ->
        expect(recurser.isArray(arr1)).toBe true
        expect(recurser.isArray(arr2)).toBe true
      it "should respond false for arrrays", ->
        expect(recurser.isArray(bool)).toBe false
        expect(recurser.isArray(num)).toBe false
        expect(recurser.isArray(str)).toBe false

    describe "literal", ->
      it "should respond false for arrrays", ->
        expect(recurser.isPlain(hash1)).toBe false
        expect(recurser.isPlain(hash2)).toBe false
        expect(recurser.isPlain(hash3)).toBe false
      it "should respond false for arrrays", ->
        expect(recurser.isPlain(arr1)).toBe false
        expect(recurser.isPlain(arr2)).toBe false
      it "should respond true for literals", ->
        expect(recurser.isPlain(bool)).toBe true
        expect(recurser.isPlain(num)).toBe true
        expect(recurser.isPlain(str)).toBe true

  describe "plain values", ->
    describe "isImplicitString", ->
      it "should be false for the empty string", ->
        str = ""
        expect(recurser.isImplicitString str).toBe false

      it "should be false for strings with non alphanumeric non space characters", ->
        str = "i am a anormal string, yes"
        expect(recurser.isImplicitString str).toBe false
        expect(recurser.implicitString str).toBe '"' + str + '"'
        str = "i am a anormal string! yes"
        expect(recurser.isImplicitString str).toBe false
        str = "i am a anormal string\t yes"
        expect(recurser.implicitString str).toBe '"' + str + '"'
        expect(recurser.isImplicitString str).toBe false
        str = "i am a anormal string: yes"
        expect(recurser.isImplicitString str).toBe false
        expect(recurser.implicitString str).toBe '"' + str + '"'
        str = "i am a a n0rm4l string\n yes"
        expect(recurser.isImplicitString str).toBe false
        expect(recurser.implicitString str).toBe '"' + str + '"'

      it "should be false for strings with leading whitespace", ->
        str = "  i am a a n0rm4l string yes"
        expect(recurser.isImplicitString str).toBe false
        expect(recurser.implicitString str).toBe '"' + str + '"'

      it "should be false for strings with trailing whitespace", ->
        str = "i am a a n0rm4l string yes  "
        expect(recurser.isImplicitString str).toBe false
        expect(recurser.implicitString str).toBe '"' + str + '"'

      it "should be true for implicit strings", ->
        str = "i am a a n0rm4l string yes"
        expect(recurser.isImplicitString str).toBe true

  describe "json2humon", ->

    beforeEach ->
      @spyj2h = sinon.spy(recurser, "json2humon")

    afterEach ->
      @spyj2h.restore()

    describe "when called on literal values", ->
      literal = 5

      beforeEach ->
        @ret = j2h(literal)

      it "should not recurse", ->
        expect(@spyj2h).not.toHaveBeenCalled()
      it "should return the literal", ->
        expect(@ret).toBe("#{literal}\n")

    describe "when called on flat hash", ->
      hash = {a: 1, b:2, c: 3 }

      beforeEach ->
        @ret = j2h(hash)
      it "should recurse once for each k,v pair of hash", ->
        expect(@spyj2h).toHaveBeenCalledThrice()
        expect(@spyj2h).toHaveBeenCalledWith 1
        expect(@spyj2h).toHaveBeenCalledWith 2 
        expect(@spyj2h).toHaveBeenCalledWith 3
      it "should return the correct hash with bindings", ->
        expect(@ret).toEqual "a: 1\nb: 2\nc: 3\n"

    describe "when called on nested hash", ->
      hash = {a: 1, b: {x: 'nestedVal', z: 'super', d: {nestedkey: 5, akey: 7}}, c: 22 }

      beforeEach ->
        @ret = j2h(hash)
        console.log "|#{@ret}|"

      it "should recurse for all nested values", ->
        expect(@spyj2h).toHaveBeenCalledWith 1
        expect(@spyj2h).toHaveBeenCalledWith {x: 'nestedVal', z: 'super', d: {nestedkey: 5, akey: 7}} 
        expect(@spyj2h).toHaveBeenCalledWith 'nestedVal'
        expect(@spyj2h).toHaveBeenCalledWith 22

      it "should return the correctly spaced value", ->
        ret = @ret
        ans =  """a: 1
               b:
                 x: nestedVal
                 z: super
                 d:
                   nestedkey: 5
                   akey: 7
               c: 22

               """

        ###
        for i in [0..ans.length]
        blank = (ch) ->
          /\s/.test ch
        printer = (ch) ->
          if blank(ch)
            "*" + ch.charCodeAt 0
          else
            ch
        console.log (printer ans[i]), (printer ret[i])
        # ret.charCodeAt( i ), ans.charCodeAt(i)
        # ####
        expect(ret.length).toEqual ans.length
        expect(ret).toEqual ans

    xdescribe "when called on flat array", ->
      array = [1, 4, 'sdf']

      beforeEach ->
        @ret = j2h(array)
      it "should recurse for each element of the array", ->
        # expect(@spyj2h).toHaveBeenCalledThrice()
        # expect(@spyj2h).toHaveBeenCalledWith 1
        # expect(@spyj2h).toHaveBeenCalledWith 4 
        # expect(@spyj2h).toHaveBeenCalledWith 'sdf'
      it "should return the correct array with get paths", ->
        # expect(@ret).toEqual [1, 4, 'sdf']
        # expect(@ret.get('0')).toEqual 1
        # expect(@ret.get('1')).toEqual 4
        # expect(@ret.get('2')).toEqual 'sdf'
    

    xdescribe "when called on nested arrays", ->
      array = [4, ["a", "b", "c"], 5]

      beforeEach ->
        @ret = j2h(array)

      it "should recurse for each element of the array", ->
        spyj2hCalledWith = @spyj2h.args
        expect(@spyj2h).toHaveBeenCalledWith 4
        expect(@spyj2h).toHaveBeenCalledWith ["a", "b", "c"]
        expect(@spyj2h).toHaveBeenCalledWith "a"
        expect(@spyj2h).toHaveBeenCalledWith "b"
        expect(@spyj2h).toHaveBeenCalledWith "c"
        expect(@spyj2h).toHaveBeenCalledWith 5

      it "should return the correct array with get paths", ->
        expect(@ret).toEqual [4, ["a", "b", "c"], 5]
        expect(@ret.get('0')).toEqual 4
        expect(@ret.get('1')).toEqual ["a", "b", "c"]
        expect(@ret.get('1.0')).toEqual "a"
        expect(@ret.get('1.1')).toEqual "b"
        expect(@ret.get('1.2')).toEqual "c"
        expect(@ret.get('2')).toEqual 5

      it "should return bindable arrays", ->
          newClass = Ember.Object.extend
            valBinding: 'target.0'
            nestedValBinding: 'target.1.2'
            target: @ret
          otherObject = window.otherObject = newClass.create()
          Ember.run =>
            otherObject.set('val', 555)
            otherObject.set('nestedVal', 666)
          expect(@ret.get('0')).toEqual 555
          expect(@ret.get('1.2')).toEqual 666
          Ember.run =>
            @ret.set('0', [1,2,3,4])
            @ret.set('1.2', "new value")
          expect(otherObject.get('val')).toEqual [1,2,3,4]
          expect(otherObject.get('nestedVal')).toEqual "new value"


    xdescribe "when called on nested", ->
      beforeEach ->
        @serialized = [
          {
          "array":[1,2,3],
          "object":{"a": true,"b": false},
          "scalar":"mountains",
          },
          [55, 66, 77]
        ]
        @ret = j2h(@serialized)
      it "should recurse correctly", ->
        expect(@spyj2h).toHaveBeenCalledWith [1,2,3]
        expect(@spyj2h).toHaveBeenCalledWith 1
        expect(@spyj2h).toHaveBeenCalledWith 2
        expect(@spyj2h).toHaveBeenCalledWith 3
        expect(@spyj2h).toHaveBeenCalledWith {a: true, b: false}
        expect(@spyj2h).toHaveBeenCalledWith true
        expect(@spyj2h).toHaveBeenCalledWith false
        expect(@spyj2h).toHaveBeenCalledWith "mountains"
        expect(@spyj2h).toHaveBeenCalledWith [55, 66, 77]
        expect(@spyj2h).toHaveBeenCalledWith  55
        expect(@spyj2h).toHaveBeenCalledWith  66
        expect(@spyj2h).toHaveBeenCalledWith  77
      it "should set up get paths correctly", ->
        expect(@ret.get('0.array')).toEqual [1,2,3]
        expect(@ret.get('0.array.0')).toEqual 1
        expect(@ret.get('0.array.1')).toEqual 2
        expect(@ret.get('0.array.2')).toEqual 3
        # TODO(syu): add a equals comparison for objects
        expect(@ret.get('0.object.a')).toEqual true
        expect(@ret.get('0.object.b')).toEqual false
        expect(@ret.get('0.scalar')).toEqual "mountains"
        expect(@ret.get('1.0')).toEqual 55
        expect(@ret.get('1.1')).toEqual 66
        expect(@ret.get('1.2')).toEqual 77

      it "should set up bindings properly", ->
          newClass = Ember.Object.extend
            arrayBinding: 'target.array'
            array0Binding: 'target.array.0'
            objectBinding: 'target.object'
            objectBBinding: 'target.object.b'
            scalarBinding: 'target.scalar'
            target: @ret.get('0')
          otherObject = window.otherObject = newClass.create()
          Ember.run =>
            otherObject.set('array', [0, 8, 7])
            otherObject.set('array0', 9)
            otherObject.set('objectB', 555)
            otherObject.set('scalar', 'new scalar')
          expect(@ret.get('0.array')).toEqual [9, 8, 7]
          expect(@ret.get('0.array.0')).toEqual 9
          expect(@ret.get('0.object.b')).toEqual 555
          expect(@ret.get('0.scalar')).toEqual 'new scalar'

          Ember.run =>
            @ret.set('0.array', [1,2,3,4])
            @ret.set('0.object.b', 554)
            @ret.set('0.scalar', 'old scalar')
          expect(otherObject.get('array')).toEqual [1,2,3,4]
          expect(otherObject.get('object.b')).toEqual 554
          expect(otherObject.get('objectB')).toEqual 554
          expect(otherObject.get('scalar')).toEqual 'old scalar'


  xdescribe "recursiveSerialize", ->
    rs = Sysys.JSONWrapper.recursiveSerialize

    beforeEach ->
      @spyRs = sinon.spy(Sysys.JSONWrapper, "recursiveSerialize")
    afterEach ->
      Sysys.JSONWrapper.recursiveSerialize.restore()

    describe "when called on literal", ->
      describe "num", ->
        literal = 5
        beforeEach ->
          @ret = rs(literal)
        it "should not recurse", ->
          expect(@spyRs).not.toHaveBeenCalled()
        it "should return the literal", ->
          expect(@ret).toBe(literal)

      describe "boolean", ->
        literal = true
        beforeEach ->
          @ret = rs(literal)
        it "should not recurse", ->
          expect(@spyRs).not.toHaveBeenCalled()
        it "should return the literal", ->
          expect(@ret).toBe(literal)

      describe "string", ->
        literal = "i am a string"
        beforeEach ->
          @ret = rs(literal)
        it "should not recurse", ->
          expect(@spyRs).not.toHaveBeenCalled()
        it "should return the literal", ->
          expect(@ret).toBe(literal)

    xdescribe "when called on flat array", ->
      array = [3, 1, 4, true, "five"]
      beforeEach ->
        @ret = rs(array)
      it "should return the proper array", ->
        expect(@ret).toEqual array
      it "should recurse one level", ->
        expect(@spyRs).toHaveBeenCalledWith 3
        expect(@spyRs).toHaveBeenCalledWith 1
        expect(@spyRs).toHaveBeenCalledWith 4
        expect(@spyRs).toHaveBeenCalledWith true
        expect(@spyRs).toHaveBeenCalledWith "five"

    xdescribe "when called on nested flat array", ->
      array = [3, 1, [1, 2, [3]], true, "five"]
      beforeEach ->
        @ret = rs(array)
      it "should return the proper array", ->
        expect(@ret).toEqual array
      it "should recurse", ->
        expect(@spyRs).toHaveBeenCalledWith([1, 2, [3]])
        expect(@spyRs).toHaveBeenCalledWith(1)
        expect(@spyRs).toHaveBeenCalledWith(2)
        expect(@spyRs).toHaveBeenCalledWith([3])
        expect(@spyRs).toHaveBeenCalledWith(3)

    xdescribe "when called on flat EnumerableObjectViaObject", ->
      content = {a: 1, b: 2, c: ["c"] }
      hash = Sysys.EnumerableObjectViaObject.create content: content
      beforeEach ->
        @ret = rs(hash)
      it "should return the correct vanilla object", ->
        expect(@ret).toEqual content
      it "should once for each key and once for the array", ->
        expect(@spyRs).toHaveBeenCalledWith 1
        expect(@spyRs).toHaveBeenCalledWith 2
        expect(@spyRs).toHaveBeenCalledWith ["c"]
        expect(@spyRs).toHaveBeenCalledWith "c"

    xdescribe "when called on nested EnumerableObjectViaObject", ->
      nested = Sysys.EnumerableObjectViaObject.create content: {nested1: "nested"}
      content = {a: 1, b: 2, c: nested  }
      hash = Sysys.EnumerableObjectViaObject.create content: content

      beforeEach ->
        @ret = rs(hash)
      it "should return the correct vanilla object", ->
        expect(@ret).toEqual {a: 1, b: 2, c: {nested1: "nested"}}
      it "should once for each key and once for the array", ->
        expect(@spyRs).toHaveBeenCalledWith 1
        expect(@spyRs).toHaveBeenCalledWith 2
        expect(@spyRs).toHaveBeenCalledWith nested
        expect(@spyRs).toHaveBeenCalledWith "nested"
        expect(@spyRs.args[0][0]).toEqual 1
        expect(@spyRs.args[1][0]).toEqual 2
        expect(@spyRs.args[2][0]).toEqual nested
        expect(@spyRs.args[3][0]).toEqual "nested"

    xdescribe "when called on flat array", ->
    xdescribe "when called on EnumerableObjectViaObject", ->
    xdescribe "when called on EnumerableObjectViaArray", ->

