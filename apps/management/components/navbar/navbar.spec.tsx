import { render } from '@testing-library/react'
import '../../test/router-test'

import Navbar from './navbar'

describe('Navbar', () => {
  it('should render successfully', () => {
    const { baseElement } = render(<Navbar />)
    expect(baseElement).toBeTruthy()
  })
})
