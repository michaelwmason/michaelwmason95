import { Component, OnDestroy, OnInit } from '@angular/core'
import { MediaObserver } from '@angular/flex-layout'
import { FormGroup } from '@angular/forms'
import { Observable, Subscription } from 'rxjs'
import { map, share } from 'rxjs/operators'
import { NavigationService } from './services/navigation/navigation.service'

@Component({
    selector: 'app-root',
    templateUrl: './app.component.html',
    styleUrls: ['./app.component.scss'],
})
export class AppComponent implements OnInit, OnDestroy {
    form: FormGroup
    subs: Subscription[] = []
    mediaAlias$: Observable<string>

    constructor(
        private navigationService: NavigationService,
        private mediaObserver: MediaObserver
    ) {}

    ngOnInit(): void {
        this.mediaAlias$ = this.mediaObserver.asObservable().pipe(
            share(),
            map((media) => media[0].mqAlias)
        )
    }

    isSelected(location: string): Observable<boolean> {
        return this.navigationService.currentLocation$.pipe(
            map((l) => l === location)
        )
    }

    ngOnDestroy(): void {
        this.subs.forEach((s) => s.unsubscribe())
    }
}
