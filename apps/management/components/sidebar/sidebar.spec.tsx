import { render } from '@testing-library/react'
import '../../test/router-test'
import Sidebar from './sidebar'

describe('Sidebar', () => {
  it('should render successfully', () => {
    const { baseElement } = render(<Sidebar />)
    expect(baseElement).toBeTruthy()
  })
})
