import Quick
import Nimble

@testable import the_artist_ios

final class ArrayChunkedSpec: QuickSpec {
    override func spec() {
        describe("Array") {
            describe(".chunked") {
                context("chunking into fragment of 1") {
                    context("with an empty array") {
                        let arrayChunked = [].chunked(into: 1)
                        
                        it("returns a empty array") {
                            expect(arrayChunked).to(beEmpty())
                        }
                    }
                    
                    context("with array with 1 element") {
                        let arrayChunked = [1].chunked(into: 1)
                        
                        it("") {
                            expect(arrayChunked.count).to(equal(1))
                            expect(arrayChunked[0]).to(equal([1]))
                        }
                    }
                    
                    context("with array with 2 elements") {
                        let arrayChunked = [1, 2].chunked(into: 1)
                        
                        it("") {
                            expect(arrayChunked.count).to(equal(2))
                            expect(arrayChunked[0]).to(equal([1]))
                            expect(arrayChunked[1]).to(equal([2]))
                        }
                    }
                    
                    context("with array with 3 elements") {
                        let arrayChunked = [1, 2, 3].chunked(into: 1)
                        
                        it("") {
                            expect(arrayChunked.count).to(equal(3))
                            expect(arrayChunked[0]).to(equal([1]))
                            expect(arrayChunked[1]).to(equal([2]))
                            expect(arrayChunked[2]).to(equal([3]))
                        }
                    }
                } // chunking into fragment of 1
                
                context("chunking into fragments of 2") {
                    context("with an empty array") {
                        let arrayChunked = [].chunked(into: 2)
                        
                        it("returns a empty array") {
                            expect(arrayChunked).to(beEmpty())
                        }
                    }
                    
                    context("with array with 1 element") {
                        let arrayChunked = [1, 2].chunked(into: 2)
                        
                        it("") {
                            expect(arrayChunked.count).to(equal(1))
                            expect(arrayChunked[0]).to(equal([1, 2]))
                        }
                    }
                } // chunking into fragments of 2
            }
        }
    }
}

