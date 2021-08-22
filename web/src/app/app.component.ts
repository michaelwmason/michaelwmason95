import { AfterViewInit, Component, OnDestroy, OnInit } from '@angular/core'
import { MediaObserver } from '@angular/flex-layout'
import { FormGroup } from '@angular/forms'
import { Observable, Subscription } from 'rxjs'
import { map } from 'rxjs/operators'

@Component({
    selector: 'app-root',
    templateUrl: './app.component.html',
    styleUrls: ['./app.component.scss'],
})
export class AppComponent implements OnInit, OnDestroy, AfterViewInit {
    form: FormGroup
    subs: Subscription[] = []
    mediaAlias$: Observable<string>

    constructor(private mediaObserver: MediaObserver) {}

    ngOnInit(): void {
        this.mediaAlias$ = this.mediaObserver
            .asObservable()
            .pipe(map((media) => media[0].mqAlias))
    }

    ngAfterViewInit(): void {}

    ngOnDestroy(): void {
        this.subs.forEach((s) => s.unsubscribe())
    }

    nav(anchor: string): void {
        document.querySelector('#' + anchor).scrollIntoView()
    }
}
