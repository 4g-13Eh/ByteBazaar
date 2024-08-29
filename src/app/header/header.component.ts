import {Component, inject, OnInit,} from '@angular/core';
import {ItemService} from "../items/item/item.service";
import {FormsModule} from "@angular/forms";
import {NavigationEnd, Router, RouterLink, RouterLinkActive} from "@angular/router";
import {AsyncPipe, CommonModule, Location, NgIf} from "@angular/common";
import {ShoppingCartService} from "../shopping-cart/shopping-cart.service";
import {BehaviorSubject, Observable} from "rxjs";
import {UserService} from "../user/user.service";
import {UserModel} from "../user/user.model";

@Component({
  selector: 'app-header',
  standalone: true,
  imports: [
    FormsModule,
    RouterLink,
    RouterLinkActive,
    AsyncPipe,
    CommonModule
  ],
  templateUrl: './header.component.html',
  styleUrl: './header.component.css'
})
export class HeaderComponent implements OnInit{
  private itemService = inject(ItemService);
  userService = inject(UserService);
  searchQuery: string = '';
  itemNamePreviews: string[] = [];
  location = inject(Location)
  private cartService = inject(ShoppingCartService);
  router = inject(Router);

  cartItemCount$!: Observable<number>;

  user: string | null = null;
  authLinkText: string = 'Anmelden';

  // constructor() {
  //   this.itemService.searchResults$.subscribe(results =>{
  //     this.itemNamePreviews = results.map(item => item.name);
  //   });
  // }

  ngOnInit() {
    this.cartItemCount$ = this.cartService.getCartItemCount().asObservable();
    this.updateLinkText();

    this.router.events.subscribe((event)=>{
      if (event instanceof NavigationEnd) {
        this.updateLinkText();
      }
    });
  }

  search() {
    this.itemService.searchItems(this.searchQuery);
  }

  onLogoutClick(){
    this.userService.logout();
    this.router.navigate(['/auth/login']).then(()=>{
      this.updateLinkText();
    });


  }

  updateLinkText() {
    this.user = this.userService.getCurrentUserId();
    const path = this.location.path();

    if (this.user) {
      this.authLinkText = 'Logout';
    } else if (this.location.isCurrentPathEqualTo('/auth/login')) {
      this.authLinkText = 'Registrieren';
    } else if (this.location.isCurrentPathEqualTo('/auth/signup')) {
      this.authLinkText = 'Anmelden';
    } else {
      this.authLinkText = 'Anmelden';
    }
  }

  // // shows a list of names that correspond to the searchquery
  // onInputChange(){
  //   this.itemNamePreviews != this.itemService.showNamePreviews(this.searchQuery);
  // }

}
