import styles from './navbar.module.css'

/* eslint-disable-next-line */
export class NavbarProps {}

export function Navbar(props: NavbarProps) {
  return (
    <div className={styles['container']}>
      <h1>Welcome to Navbar!</h1>
    </div>
  )
}

export default Navbar
