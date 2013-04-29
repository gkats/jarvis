describe 'Jarvis.Models.Interval', ->
  describe '#new', ->
    it 'assigns from and to values', ->
      interval = new Jarvis.Models.Interval(1, 2)
      expect(interval.from).toEqual(1)
      expect(interval.to).toEqual(2)

  describe '#fromMonth', ->
    describe 'when the month is in the past', ->
      beforeEach ->
        @month = new Date().getMonth() - 1
        @year = new Date().getFullYear()

      it 'creates a monthly interval in the current year', ->
        interval = Jarvis.Models.Interval.fromMonth(@month)
        expect(interval.from).toEqual(new Date(@year, @month - 1))
        expect(interval.to).toEqual(new Date(@year, @month, 0))

    describe 'when the month is in the future', ->
      beforeEach ->
        @month = new Date().getMonth() + 2
        @year = new Date().getFullYear() - 1

      it 'creates a monthly interval for the past year', ->
        interval = Jarvis.Models.Interval.fromMonth(@month)
        expect(interval.from).toEqual(new Date(@year, @month - 1))
        expect(interval.to).toEqual(new Date(@year, @month, 0))