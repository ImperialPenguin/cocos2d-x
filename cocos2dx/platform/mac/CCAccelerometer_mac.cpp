//
//  CCAccelerometer_mac.cpp
//  test
//
//  Created by John Garrison on 6/15/12.
//  Copyright (c) 2012 Imperial Penguin. All rights reserved.
//
/* Permission is hereby granted, free of charge, to any person obtaining a copy
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
****************************************************************************/

#include <iostream>

#include "CCAccelerometer_mac.h"

namespace cocos2d
{
	CCAccelerometer* CCAccelerometer::m_spCCAccelerometer = NULL;
    
	CCAccelerometer::CCAccelerometer() : m_pAccelDelegate(NULL)
	{
	}
    
    CCAccelerometer::~CCAccelerometer() 
	{
		m_spCCAccelerometer = NULL;
    }
    
    CCAccelerometer* CCAccelerometer::sharedAccelerometer() 
	{
    	if (m_spCCAccelerometer == NULL)
    	{
    		m_spCCAccelerometer = new CCAccelerometer();
    	}
    	
    	return m_spCCAccelerometer;
    }
    
    void CCAccelerometer::setDelegate(CCAccelerometerDelegate* pDelegate)
    {
    	m_pAccelDelegate = pDelegate;
    }
    
	void CCAccelerometer::update(int x, int y, int z, long timeStamp)
	{		
		if ( m_pAccelDelegate != NULL)
		{
			double dX, dY, dZ;
            
			dX = (float)x / 32768.0;
			dY = (float)y / 32768.0;
			dZ = (float)z / 32768.0;
			m_accelerationValue.x = dX;
			m_accelerationValue.y = -dY;
			m_accelerationValue.z = dZ;
			m_accelerationValue.timestamp = (double)timeStamp;
            
			m_pAccelDelegate->didAccelerate(&m_accelerationValue);
		}
	}
    
} // end of namespace cococs2d
