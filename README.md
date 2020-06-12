# IEXSwift
A Swift wrapper for IEX

## Usage

### Adding framework

• Open the .xcodeproj file

• Build to verify compilation

• Drag the .framework file into your project

<p align="left">
  <img src="https://imgur.com/iOWzD2l.png" alt="image">
</p>

• Enable incoming and outgoing connections

<p align="left">
  <img src="https://imgur.com/5AbipVd.png" alt="image">
</p>

Now IEXSwift can be imported and used in your project.

### Using IEXSwift

IEX requires that an api key be used, make sure to <a href="https://iexcloud.io">create an account</a> to do so

Import IEXSwift and create an instance of IEX or initialize the shared one.


```swift
import IEX

// initialize with API key
IEX.shared = IEX(apiKey: myAPIKey)

// can set type to sandbox if using sandbox testing
IEX.shared?.baseURL = .sandbox

// fault tolerant fetch of Boeing stock price
if let baPrice = IEX.shared?.priceOnly(symbol: "BA") {
    print(baPrice)
}

```

Wrapper matches IEX stock documentation found <a href="https://iexcloud.io/docs/api/#stock-prices">here</a>

## License (MIT)

Copyright (c) 2020 - Jackson Utsch

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
