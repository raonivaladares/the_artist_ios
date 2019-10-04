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
                        
                        it("returns an array of size 1") {
                            expect(arrayChunked.count).to(equal(1))
                            expect(arrayChunked[0]).to(equal([1]))
                        }
                    }
                    
                    context("with array with 2 elements") {
                        let arrayChunked = [1, 2].chunked(into: 1)
                        
                        it("returns an array of size 2") {
                            expect(arrayChunked.count).to(equal(2))
                            expect(arrayChunked[0]).to(equal([1]))
                            expect(arrayChunked[1]).to(equal([2]))
                        }
                    }
                    
                    context("with array with 3 elements") {
                        let arrayChunked = [1, 2, 3].chunked(into: 1)
                        
                        it("returns an array of size 3") {
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
                        let arrayChunked = [1].chunked(into: 2)
                        
                        it("returns an array of size 1") {
                            expect(arrayChunked.count).to(equal(1))
                            expect(arrayChunked[0]).to(equal([1]))
                        }
                    }
                    
                    context("with array with 2 element") {
                        let arrayChunked = [1, 2].chunked(into: 2)
                        
                        it("returns an array of size 2") {
                            expect(arrayChunked.count).to(equal(1))
                            expect(arrayChunked[0]).to(equal([1, 2]))
                        }
                    }
                    
                    context("with array with 3 element") {
                        let arrayChunked = [1, 2, 3].chunked(into: 2)
                        
                        it("returns an array of size 2") {
                            expect(arrayChunked.count).to(equal(2))
                            expect(arrayChunked[0]).to(equal([1, 2]))
                            expect(arrayChunked[1]).to(equal([3]))
                        }
                    }
                    
                    context("with array with 5 element") {
                        let arrayChunked = [1, 2, 3, 4, 5].chunked(into: 2)

                        it("returns an array of size 3") {
                            expect(arrayChunked.count).to(equal(3))
                            expect(arrayChunked[0]).to(equal([1, 2]))
                            expect(arrayChunked[1]).to(equal([3, 4]))
                            expect(arrayChunked[2]).to(equal([5]))
                        }
                    }
                } // chunking into fragments of 2
            }
        }
    }
}

