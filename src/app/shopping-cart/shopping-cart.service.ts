import {inject, Injectable} from '@angular/core';
import {BehaviorSubject} from "rxjs";
import {ShoppingCartItemModel} from "./shopping-cart-item.model";
import {ShoppingCartModel} from "./shoppingcart.model";
import { v4 as uuidv4 } from "uuid";
import {UserService} from "../user/user.service";
import {ItemService} from "../items/item/item.service";

@Injectable({
  providedIn: 'root'
})
export class ShoppingCartService {
  private cartsKey = 'carts';
  private userService = inject(UserService);
  itemService = inject(ItemService);
  private cartItemCount = new BehaviorSubject<number>(0);

  constructor() {
    this.updateCartItemCount();
  }

  private createCart(){
    let carts: ShoppingCartModel[] = JSON.parse(localStorage.getItem(this.cartsKey) || '[]');

    const newCart: ShoppingCartModel = {
      id: uuidv4().toString(),
      items: []
    };

    carts.push(newCart);
    localStorage.setItem(this.cartsKey, JSON.stringify(carts));

    return newCart;
  }

  private getCartById(cartId: string | null): ShoppingCartModel | null {
    const carts = JSON.parse(localStorage.getItem(this.cartsKey) || '[]');
    console.log("Fetching cart with ID:", cartId, "Found carts:", carts); // Log to check retrieved data
    return carts.find((cart: ShoppingCartModel) => cart.id === cartId) || null;
  }

  private saveCart(cart: ShoppingCartModel) {
    let carts: ShoppingCartModel[] = JSON.parse(localStorage.getItem(this.cartsKey) || '[]');
    const cartIndex = carts.findIndex(c => c.id === cart.id);
    if (cartIndex !== -1) {
      carts[cartIndex] = cart;
    } else {
      carts.push(cart);
    }
    console.log("Saving cart:", JSON.stringify(carts))
    localStorage.setItem(this.cartsKey, JSON.stringify(carts));
  }

  getCartItems(): ShoppingCartItemModel[]{
    const currentUser = this.userService.getCurrentUser();
    if (!currentUser) return [];

    const cart = this.getCartById(currentUser.cartId);
    return cart ? cart.items : [];
  }

  addItemToCart(item: ShoppingCartItemModel, quantity: number = 1){
    const currentUser = this.userService.getCurrentUser();
    if (!currentUser) return;

    let cart = this.getCartById(currentUser.cartId);
    if (!cart) {
      cart = this.createCart();
      currentUser.cartId = cart.id;
      this.userService.updateUser(currentUser);
    }

    let currentStock = this.itemService.getItemStockNum(item.item.id);
    const existingItem =
      cart.items.find((cartItem: ShoppingCartItemModel) => cartItem.item.id === item.item.id);
    if (existingItem){
      if (existingItem.quantity + quantity <= currentStock){
        existingItem.quantity += quantity;
      } else{
        console.log('Cannot add more items. Stock limit reached.');
      }
    } else{
      if (quantity <= currentStock){
        item.quantity = quantity;
        cart.items.push(item);
      } else {
        console.log('Cannot add more items. Stock limit reached.');
        return;
      }
    }

    this.saveCart(cart);
    this.updateCartItemCount();
    this.itemService.decreaseItemStock(item.item.id, quantity);
  }

  decreaseItemQuantity(itemId: string, quantity: number){
    const currentUser = this.userService.getCurrentUser();
    if (!currentUser) return;

    const cart = this.getCartById(currentUser.cartId);
    if (!cart) return;

    const item = cart.items.find(cartItem => cartItem.item.id === itemId);
    if (item){
      item.quantity -= quantity;
      if (item.quantity <= 0){
        cart.items = cart.items.filter(cartItem => cartItem.item.id !== itemId);
      }
      this.saveCart(cart);
      this.updateCartItemCount();

      this.itemService.increaseItemStock(itemId, quantity);
    }
  }

  removeItemFromCart(itemId: string){
    const currentUser = this.userService.getCurrentUser();
    if (!currentUser) return;

    const cart = this.getCartById(currentUser.cartId);
    if (!cart) return;

    const item = cart.items.find(item => item.item.id === itemId);
    if (item) {
      this.itemService.increaseItemStock(itemId, item.quantity);
      cart.items = cart.items.filter(cartItem => cartItem.item.id !== itemId);
      this.saveCart(cart);
      this.updateCartItemCount();
    }

    this.saveCart(cart);
    this.updateCartItemCount();
  }

  clearCart(){
    const currentUser = this.userService.getCurrentUser();
    if (!currentUser) return;

    const cart = this.getCartById(currentUser.cartId);
    if (!cart) return;

    cart.items = [];
    this.saveCart(cart);
    this.updateCartItemCount();
  }

  getCartItemCount(): BehaviorSubject<number> {
    console.log(this.cartItemCount)
    return this.cartItemCount;
  }

  private updateCartItemCount(): void {
    const currentUser = this.userService.getCurrentUser();
    if (!currentUser) return;

    const cart = this.getCartById(currentUser.cartId);
    if (!cart) {
      this.cartItemCount.next(0);
      return;
    }

    const totalItems = cart.items.reduce(
      (sum: number, cartItem: ShoppingCartItemModel) => sum + cartItem.quantity, 0
    );

    console.log("Updating cart item count to:", totalItems); // Log to check updated count
    this.cartItemCount.next(totalItems);
  }
}
